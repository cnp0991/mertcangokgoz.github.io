---
layout: post
title: Centos 7 Üzerine CachetHQ Kurulumu
date: 2017-03-30
type: post
categories: linux
description: Projemizin status sayfası için yana döne bir şeyler arıyordum sonuçta bunu da el ile yapmak olmaz. Sonra google arama sonuçlarında CachetHQ
---

Projemizin status sayfası için yana döne bir şeyler arıyordum sonuçta bunu da el ile yapmak olmaz. Sonra google arama sonuçlarında CachetHQ adında PHP ve laravel kullanarak yazılmış güzel bir uygulama gözüme çarptı.

ilk önce web server ve geriye kalan şeyleri kuralım

```
yum install -y epel-release
yum install nginx mariadb-server php5-fpm php5-mysql
yum update
```

Şimdi githubdan repoyu indirelim. direk web serverin dizine indirmeyi unutmayın unutursanızda sonradan taşıyın ki sorun olmasın

```
cd /var/www/html
git clone https://github.com/cachethq/Cachet.git
cd Cachet
```

Biraz ortalarda yapıyoruz gibi olacak ama mysql için bi kurulum yapmamız gerekiyor ön tanımlı kullanıcıyı tanımlamak için vs

```
mysql_secure_installation
```

Şimdi bu girdiğiniz Cachet klasörünün içerisinde .env.example diye bir dosya var bunun adını aşağıdakinin yardımı ile değiştiriyoruz.

```
sudo mv .env.example .env
```

Nano ile bu dosyanın içerisine giriyoruz.

```
APP_ENV=production
APP_DEBUG=false
APP_URL=http://localhost
APP_KEY=SomeRandomString

DB_DRIVER=mysql
DB_HOST=localhost
DB_DATABASE=cachet
DB_USERNAME=homestead
DB_PASSWORD=secret
DB_PORT=null

CACHE_DRIVER=apc
SESSION_DRIVER=apc
QUEUE_DRIVER=database
CACHET_EMOJI=false

MAIL_DRIVER=smtp
MAIL_HOST=mailtrap.io
MAIL_PORT=2525
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ADDRESS=null
MAIL_NAME="Project Status Page"
MAIL_ENCRYPTION=tls

REDIS_HOST=null
REDIS_DATABASE=null
REDIS_PORT=null

GITHUB_TOKEN=null
```

Bu işlemi de başarılı bir şekilde yaptıysanız sıra geldi composer indirmeye dediğim gibi bu arkadaş php frameworkü ile yazıldığı için biraz teferruatlı

```
sudo curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer 
```

Sonra bir güzel kuruyoruz.

```
sudo composer install --no-dev -o
```

Daha ileri gitmeden önce, APP_KEY yapılandırmasını ayarlamamız gerekecek. Bu, Cachet'de kullanılan tüm şifrelemeler için kullanılacak

```
php artisan key:generate
```

Bu komutu çalıştırmadan önce **.env** için doğru izinlere sahip olduğunuzdan emin olun. Eminseniz artık kurulumu sonlandıralım

```
php artisan app:install
```

Sıra geldi nginx için yapılandırmalara

```
# Upstream to abstract backend connection(s) for php
upstream php {
    server unix:/tmp/php-cgi.socket;
    server 127.0.0.1:9000;
}

server {
    server_name  cachet.mycompany.com; 
    listen 80 default;
    rewrite ^(.*) https://cachet.mycompany.com$1 permanent;
}

# HTTPS server

server {
    listen 443;
    server_name cachet.mycompany.com;

    root /var/vhost/cachet.mycompany.com/public;
    index index.php;

    ssl on;
    ssl_certificate /etc/ssl/crt/cachet.mycompany.com.crt; # Or wherever your crt is
    ssl_certificate_key /etc/ssl/key/cachet.mycompany.com.key; # Or wherever your key is
    ssl_session_timeout 5m;

    # Best practice as at March 2014
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_prefer_server_ciphers on;
    ssl_ciphers "ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:kEDH+AESGCM:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-DSS-AES128-SHA256:DHE-RSA-AES256-SHA256:DHE-DSS-AES256-SHA:DHE-RSA-AES256-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:AES:CAMELLIA:DES-CBC3-SHA:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!MD5:!PSK:!aECDH:!EDH-DSS-DES-CBC3-SHA:!EDH-RSA-DES-CBC3-SHA:!KRB5-DES-CBC3-SHA";
    ssl_buffer_size 1400; # 1400 bytes, within MTU - because we generally have small responses. Could increase to 4k, but default 16k is too big

    location / {
        add_header Strict-Transport-Security max-age=15768000;
        try_files $uri /index.php$is_args$args;
    }

    location ~ \.php$ {
                include fastcgi_params;
                fastcgi_pass unix:/var/run/php5-fpm.sock;
                fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
                fastcgi_index index.php;
                fastcgi_keep_conn on;
                add_header Strict-Transport-Security max-age=15768000;
    }
}
```

Daha sonrasında `nginx` ve `php5` yi çalıştırın.

Yukardaki ayar dosyası içerisinde **SSL** kurulumu gerektirecek parametreler bulunmaktadır. Kısacası size 1 adet 1 yıl geçerli bir **SSL** gerekmektedir. Bunu unutmayın sonra yok efendim çalışmıyo olmasın.

