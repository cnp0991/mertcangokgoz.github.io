---
layout: post
title: Biri Bizi Gözetliyor E-Mail Tracking 
date: 2017-02-06
type: post
categories: guvenlik
description: Çok sayıda şirket ve posta hizmetleri sağlayan kurumlar kişiselleştirilmiş bir url içeren postalarına küçük görünmez görüntüler koyuyor
---

Çok sayıda şirket ve posta hizmetleri sağlayan kurumlar kişiselleştirilmiş bir url içeren postalarına küçük görünmez görüntüler koyuyor. Postalarını her açtığınızda, bu resim sunucudan yüklenir ve şirket size gönderilen bu postanın açıldığını bilir. Örnek olarak şu şekilde

Örnek 1

```
 <img src="http://tracker.com/trk?yourid=<some_random_string>" 
         width="1" 
         height="1" 
         style="display:none !important;" 
         alt="">
```

Örnek 2

```
<img src=3D"https://mailing.g2a.com/open.html?x=3Da62e&m=3DVh=
&mc=3Df&s=3DlytFt&u=3Dl&y=3D9&" 
		width=3D"0" 
		height=3D"0" 
		border=3D"0" />
```

Spam maillerin sana ulaştığını bu firmalar işte bu şekilde anlar sen maili açarsın çünkü ney olup bittiğini anlamak için - ve daha fazla mail göndermek için güzel bir başlangıç yakalamış olunur.

### Bunu nasıl önleyeyebiliriz ?

Programların bağlanmak istediği yerleri gösteren araçlar vardır. Ancak çoğu zaman bu uygulamalar ücretlidir. Listede henüz bulunmayan yeni bir urlyi bu uygulamalar aracılığı ile keşfede bilirsiniz.

Bununla birlikte, izlemeyi engellemenin en kolay ve en kolay yolu, bilgisayarınızda bulunan`hosts` dosyanıza URL'ler eklemenizdir. Bu, sisteminizin izleme bağlantılarını `0.0.0.0` yönlendirmenize yardımcı olacak ve bu bağlantılardan gelecek isteklere sisteminiz kulak asmayacaktır.

```
0.0.0.0     track.mixmax.com
0.0.0.0     securepubads.g.doubleclick.net
0.0.0.0     click.mailer.atlassian.com
0.0.0.0     marketing.intercom-mail-200.com 
0.0.0.0     mailchimp.com
0.0.0.0     list-manage.com
0.0.0.0     cl.exct.net
0.0.0.0     emailtracking.azure.com
0.0.0.0     trker1.azalead.com
0.0.0.0     mkto-k0023.com
0.0.0.0     maileon.com
0.0.0.0     xqueue.de
0.0.0.0     t.yesware.com
0.0.0.0     track.getsidekick.com
0.0.0.0     t.sigopn01.com
0.0.0.0     t.senaluno.com
0.0.0.0     t.senaldos.com
0.0.0.0     t.senaltres.com
0.0.0.0     t.senalquatro.com
0.0.0.0     t.senalcinco.com
0.0.0.0     t.sigopn02.com
0.0.0.0     t.sigopn03.com
0.0.0.0     t.sigopn04.com
0.0.0.0     t.sigopn05.com
0.0.0.0     t.signauxun.com
0.0.0.0     t.signauxdeux.com
0.0.0.0     t.signauxtrois.com
0.0.0.0     t.signauxquatre.com
0.0.0.0     t.signauxcinq.com
0.0.0.0     t.signauxsix.com
0.0.0.0     t.signauxsept.com
0.0.0.0     t.signauxhuit.com
0.0.0.0     t.signauxdix.com
0.0.0.0     t.signauxneuf.com
0.0.0.0     t.signaleuna.com
0.0.0.0     t.signaledue.com
0.0.0.0     t.signaletre.com
0.0.0.0     t.signalequattro.com
0.0.0.0     t.signalecinque.com
0.0.0.0     t.strk01.email
0.0.0.0     t.strk02.email
0.0.0.0     t.strk03.email
0.0.0.0     t.strk04.email
0.0.0.0     t.strk05.email
0.0.0.0     t.strk06.email
0.0.0.0     t.strk07.email
0.0.0.0     t.strk08.email
0.0.0.0     t.strk09.email
0.0.0.0     t.strk10.email
0.0.0.0     t.strk11.email
0.0.0.0     t.strk12.email
0.0.0.0     t.strk13.email
0.0.0.0     t.sidekickopen01.com
0.0.0.0     t.sidekickopen02.com
0.0.0.0     t.sidekickopen03.com
0.0.0.0     t.sidekickopen04.com
0.0.0.0     t.sidekickopen05.com
0.0.0.0     t.sidekickopen06.com
0.0.0.0     t.sidekickopen07.com
0.0.0.0     t.sidekickopen08.com
0.0.0.0     t.sidekickopen09.com
0.0.0.0     t.sidekickopen10.com
0.0.0.0     t.sidekickopen11.com
0.0.0.0     t.sidekickopen12.com
0.0.0.0     mailtrack.io
0.0.0.0     mailstat.us
0.0.0.0     go.toutapp.com
0.0.0.0     app.outreach.io
0.0.0.0     tracking.cirrusinsight.com
0.0.0.0     app.yesware.com
0.0.0.0     t.yesware.com
0.0.0.0     mailfoogae.appspot.com
0.0.0.0     launchbit.com
0.0.0.0     cmail1.com
0.0.0.0     infusionsoft.com
0.0.0.0     via.intercom.io
0.0.0.0     mandrillapp.com
0.0.0.0     t.hsms06.com
0.0.0.0     app.relateiq.com
0.0.0.0     go.rjmetrics.com
0.0.0.0     web.frontapp.com
0.0.0.0     sendgrid.net
0.0.0.0     icptrack.com
0.0.0.0     click.icptrack.com
0.0.0.0     bl-1.com
0.0.0.0     links.mixmax.com
0.0.0.0     app.mixmax.com
0.0.0.0     ping.answerbook.com
0.0.0.0     constantcontact.com
0.0.0.0     google-analytics.com
0.0.0.0     mkt4477.com
0.0.0.0     api.mixpanel.com
0.0.0.0     mixpanel.com
0.0.0.0     list-manage.com
0.0.0.0     list-manage1.com
0.0.0.0     o1.mailing.sh.com.tr
```

Bu şekilde bazılarını engelleyebilirsiniz. Ancak bu hizmeti veren oldukça fazla firma var bunların her birinin url adreslerini tek tek tespit etmek ve engellemek gerekiyor ki e-postalarınızın açılıp açılmadığını göremesinler. Spam atılan her bir mesaj o mail adresinin kullanılıp kullanılmadığını anlamak için bile gönderiliyor olabilir. Bunu aklınızın bir köşesine not edin.

Bu iş için geliştirilmiş bir adet tarayıcı eklentisi mevcut [PixelBlock](https://chrome.google.com/webstore/detail/pixelblock/jmpmfcjnflbcoidlgapblgpgbilinlem) bu eklenti aracılığı ile mailler içerisinde eğer yukarda bahsi geçen bir içerik varsa hemen engelleyecek ve otomatik olarak size bildirim gönderecek

Yeni bir takım url tespit ederseniz lütfen `Pull Request` isteği ile göndermeyi unutmayın. Peki en basiti bu url bilgilerini veya izlendiğimizi nasıl anlayacağız.

### Bunun dışında nasıl yardım edebilirim?

Okuduğunuz mail bir şirket, kurum veya kuruluştan birisi tarafından bir e-posta alırsanız, kaynağa (*) bakın ve yukarıdaki kod gibi bir şeyler bulmaya çalışın. Genellikle postanın sonunda bulunur.

Aynı şekilde thunderbird kullanıyorsanız mailin kaynağına bakın kaynakta en sonra `click` ve(veya) `open` şeklinde yönlendirmelerde görebilirsiniz. Bu yönlendirmelere karşılık gelen domain bilgilerini bize gönderebilirsiniz.