---
layout: post
title: Django ReCaptcha Eklenti Düzenleme
date: 2017-02-20
type: post
categories: programlama
description: Günlerden bir gün django projesi ile baya içli dışlı olmuştuk ve recaptcha uygulaması gerekiyordu. Var olan uygulamaya da baktık kurması 
---

Günlerden bir gün django projesi ile baya içli dışlı olmuştuk ve recaptcha uygulaması gerekiyordu. Var olan uygulamaya da baktık kurması dert kurcalaması dert bizde düşündük zaten açık kaynak kodlu kodları kendi içimize alalım hem daha sonradan değişiklik yapılacaksa bize kod bakımından kolay olur.

İlk önce tabi düşündük sıfırdan yazalım diye ancak daha sonradan uğraşmak istemedik. Aşağıdakileri sırasıyla projenize dahil etmeniz yeterli.

fields.py

```
import os
import sys
import socket
from django import forms
from django.conf import settings
from django.core.exceptions import ValidationError
from django.utils.translation import ugettext_lazy as _
from django.utils.encoding import smart_text as smart_unicode
from StreamingTwitter.widgets import ReCaptcha
from StreamingTwitter.ReCaptcha import submit

TEST_PUBLIC_KEY = '6LeIxAcTAAAAAJcZVRqyHh71UMIEGNQ_MXjiZKhI'
TEST_PRIVATE_KEY = '6LeIxAcTAAAAAGG-vFI1TnRWxMZNFuojJ4WifJWe'


class ReCaptchaField(forms.CharField):
    default_error_messages = {
        'captcha_invalid': _('Incorrect, please try again.'),
        'captcha_error': _('Error verifying input, please try again.'),
    }

    def __init__(self, public_key=None, private_key=None, use_ssl=None,
                 attrs=None, *args, **kwargs):
        """
        ReCaptchaField can accepts attributes which is a dictionary of
        attributes to be passed to the ReCaptcha widget class. The widget will
        loop over any options added and create the RecaptchaOptions
        JavaScript variables as specified in
        https://code.google.com/apis/recaptcha/docs/customization.html
        """
        if attrs is None:
            attrs = {}
        public_key = public_key if public_key else \
            getattr(settings, 'RECAPTCHA_PUBLIC_KEY', TEST_PUBLIC_KEY)
        self.private_key = private_key if private_key else \
            getattr(settings, 'RECAPTCHA_PRIVATE_KEY', TEST_PRIVATE_KEY)
        self.use_ssl = use_ssl if use_ssl is not None else getattr(
            settings, 'RECAPTCHA_USE_SSL', True)

        self.widget = ReCaptcha(
            public_key=public_key, use_ssl=self.use_ssl, attrs=attrs)
        self.required = True
        super(ReCaptchaField, self).__init__(*args, **kwargs)

    def get_remote_ip(self):
        f = sys._getframe()
        while f:
            if 'request' in f.f_locals:
                request = f.f_locals['request']
                if request:
                    remote_ip = request.META.get('REMOTE_ADDR', '')
                    forwarded_ip = request.META.get('HTTP_X_FORWARDED_FOR', '')
                    ip = remote_ip if not forwarded_ip else forwarded_ip
                    return ip
            f = f.f_back

    def clean(self, values):
        super(ReCaptchaField, self).clean(values[1])
        recaptcha_challenge_value = smart_unicode(values[0])
        recaptcha_response_value = smart_unicode(values[1])

        if os.environ.get('RECAPTCHA_TESTING', None) == 'True' and \
                        recaptcha_response_value == 'PASSED':
            return values[0]

        if not self.required:
            return

        try:
            check_captcha = submit(
                recaptcha_challenge_value,
                recaptcha_response_value, private_key=self.private_key,
                remoteip=self.get_remote_ip(), use_ssl=self.use_ssl)

        except socket.error:  # Catch timeouts, etc
            raise ValidationError(
                self.error_messages['captcha_error']
            )

        if not check_captcha.is_valid:
            raise ValidationError(
                self.error_messages['captcha_invalid']
            )
        return values[0]
```

widgets.py

```
from StreamingTwitter.ReCaptcha import displayhtml
from django.utils.safestring import mark_safe
from django import forms
from django.conf import settings

TEST_PUBLIC_KEY = '6LeIxAcTAAAAAJcZVRqyHh71UMIEGNQ_MXjiZKhI'


class ReCaptcha(forms.widgets.Widget):
    if getattr(settings, "NOCAPTCHA", False):
        recaptcha_response_name = 'g-recaptcha-response'
        recaptcha_challenge_name = 'g-recaptcha-response'
    else:
        recaptcha_challenge_name = 'recaptcha_challenge_field'
        recaptcha_response_name = 'recaptcha_response_field'

    def __init__(self, public_key=None, use_ssl=None, attrs=None, *args,
                 **kwargs):
        self.public_key = public_key or getattr(settings, 'RECAPTCHA_PUBLIC_KEY', TEST_PUBLIC_KEY)
        if attrs is None:
            attrs = {}
        self.use_ssl = use_ssl if use_ssl is not None else getattr(
            settings, 'RECAPTCHA_USE_SSL', True)
        self.js_attrs = attrs
        super(ReCaptcha, self).__init__(*args, **kwargs)

    def render(self, name, value, attrs=None):
        return mark_safe(u'%s' % displayhtml(
            self.public_key,
            self.js_attrs, use_ssl=self.use_ssl))

    def value_from_datadict(self, data, files, name):
        return [
            data.get(self.recaptcha_challenge_name, None),
            data.get(self.recaptcha_response_name, None)
        ]
```

ReCaptcha.py

```
import json
from django.conf import settings
from django.template.loader import render_to_string
from django.utils.safestring import mark_safe
from urllib.parse import urlencode
from urllib.request import build_opener, ProxyHandler, Request, urlopen

DEFAULT_API_SSL_SERVER = "//www.google.com/recaptcha/api"
DEFAULT_API_SERVER = "//www.google.com/recaptcha/api"
DEFAULT_VERIFY_SERVER = "www.google.com"
DEFAULT_WIDGET_TEMPLATE = 'captcha/captcha.html'

API_SSL_SERVER = getattr(settings, "CAPTCHA_API_SSL_SERVER",
                         DEFAULT_API_SSL_SERVER)
API_SERVER = getattr(settings, "CAPTCHA_API_SERVER", DEFAULT_API_SERVER)
VERIFY_SERVER = getattr(settings, "CAPTCHA_VERIFY_SERVER",
                        DEFAULT_VERIFY_SERVER)
WIDGET_TEMPLATE = getattr(settings, "CAPTCHA_WIDGET_TEMPLATE",
                          DEFAULT_WIDGET_TEMPLATE)


def want_bytes(s, encoding='utf-8', errors='strict'):
    if isinstance(s, str):
        s = s.encode(encoding, errors)
    return s


class RecaptchaResponse(object):
    def __init__(self, is_valid, error_code=None):
        self.is_valid = is_valid
        self.error_code = error_code


def displayhtml(public_key,
                attrs,
                use_ssl=True,
                error=None):
    """Gets the HTML to display for reCAPTCHA
    public_key -- The public api key
    use_ssl -- Should the request be sent over ssl? (deprecated)
    error -- An error message to display (from RecaptchaResponse.error_code)"""

    error_param = ''
    if error:
        error_param = '&error=%s' % error

    if use_ssl:
        server = API_SSL_SERVER
    else:
        server = API_SERVER

    return render_to_string(
        WIDGET_TEMPLATE,
        {'api_server': server,
         'public_key': public_key,
         'error_param': error_param,
         'options': mark_safe(json.dumps(attrs, indent=2)),
         'options_dict': attrs,
         })


def request(*args, **kwargs):
    """
    Make a HTTP request with a proxy if configured.
    """
    if getattr(settings, 'RECAPTCHA_PROXY', False):
        proxy = ProxyHandler({
            'http': settings.RECAPTCHA_PROXY,
            'https': settings.RECAPTCHA_PROXY,
        })
        opener = build_opener(proxy)

        return opener.open(*args, **kwargs)
    else:
        return urlopen(*args, **kwargs)


def submit(recaptcha_challenge_field,
           recaptcha_response_field,
           private_key,
           remoteip,
           use_ssl=False):
    if not (recaptcha_response_field and recaptcha_challenge_field and
                len(recaptcha_response_field) and len(recaptcha_challenge_field)):
        return RecaptchaResponse(
            is_valid=False,
            error_code='incorrect-captcha-sol'
        )

    if getattr(settings, "NOCAPTCHA", False):
        params = urlencode({
            'secret': want_bytes(private_key),
            'response': want_bytes(recaptcha_response_field),
            'remoteip': want_bytes(remoteip),
        })
    else:
        params = urlencode({
            'privatekey': want_bytes(private_key),
            'remoteip': want_bytes(remoteip),
            'challenge': want_bytes(recaptcha_challenge_field),
            'response': want_bytes(recaptcha_response_field),
        })

    params = params.encode('utf-8')

    if use_ssl:
        verify_url = 'https://%s/recaptcha/api/verify' % VERIFY_SERVER
    else:
        verify_url = 'http://%s/recaptcha/api/verify' % VERIFY_SERVER

    if getattr(settings, "NOCAPTCHA", False):
        verify_url = 'https://%s/recaptcha/api/siteverify' % VERIFY_SERVER

    req = Request(
        url=verify_url,
        data=params,
        headers={
            'Content-type': 'application/x-www-form-urlencoded',
            'User-agent': 'Stream reCAPTCHA Python'
        }
    )

    httpresp = request(req)
    if getattr(settings, "NOCAPTCHA", False):
        data = json.loads(httpresp.read().decode('utf-8'))
        return_code = data['success']
        return_values = [return_code, None]
        if return_code:
            return_code = 'true'
        else:
            return_code = 'false'
    else:
        return_values = httpresp.read().decode('utf-8').splitlines()
        return_code = return_values[0]

    httpresp.close()

    if (return_code == "true"):
        return RecaptchaResponse(is_valid=True)
    else:
        return RecaptchaResponse(is_valid=False, error_code=return_values[1])
```

Ardından projenizde nerede kullanacaksanız. Direk olarak oraya aşağıdaki gibi bir ekleme yaparak `html` içerisine çağırmanız yeterli

views.py dosyanızın içerisine aşağıdaki satırları ekleyin.

```
re_captcha = {'captcha': FormWithCaptcha()}
```

HTML dosyanız içerisine de

```
{{ captcha }}
```

Tam olarak çalışmasını istiyorsak `settings.py` dosyasına şu kısımları da eklemeyi unutmayın

```
RECAPTCHA_PUBLIC_KEY = '6Le61ykTAAAAACmvsDyHdzYHei_xkS4fNjEYFgmO'
RECAPTCHA_SECRET_KEY = '6Le61ykTAAAAABEXwzMb9r_-J8kr9VfoNa0jWk_'
NOCAPTCHA = True
```

Recaptcha özelliği otomatik olarak gelecek ve kolaylıkla yönetebileceksiniz. Ayrıca bu eklenti ile birden fazla sayfada ReCaptcha özelliğini aktif edip kullanabilmenize imkan sağlar diğerleri gibi sadece tek sayfada kullanılabilir bir şekilde ayarlanmamıştır.