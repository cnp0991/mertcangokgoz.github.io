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
0.0.0.0   track.mixmax.com
0.0.0.0   securepubads.g.doubleclick.net
0.0.0.0   click.mailer.atlassian.com
0.0.0.0   marketing.intercom-mail-200.com 
0.0.0.0   mailchimp.com
0.0.0.0   list-manage.com
0.0.0.0   cl.exct.net
0.0.0.0   emailtracking.azure.com
0.0.0.0   trker1.azalead.com
0.0.0.0   mkto-k0023.com
0.0.0.0   maileon.com
0.0.0.0   xqueue.de
```

Bu şekilde bazılarını engelleyebilirsiniz. Ancak bu hizmeti veren oldukça fazla firma var bunların her birinin url adreslerini tek tek tespit etmek ve engellemek gerekiyor ki e-postalarınızın açılıp açılmadığını göremesinler. Spam atılan her bir mesaj o mail adresinin kullanılıp kullanılmadığını anlamak için bile gönderiliyor olabilir. Bunu aklınızın bir köşesine not edin.

Bu iş için geliştirilmiş bir adet tarayıcı eklentisi mevcut [PixelBlock](https://chrome.google.com/webstore/detail/pixelblock/jmpmfcjnflbcoidlgapblgpgbilinlem) bu eklenti aracılığı ile mailler içerisinde eğer yukarda bahsi geçen bir içerik varsa hemen engelleyecek ve otomatik olarak size bildirim gönderecek

Yeni bir takım url tespit ederseniz lütfen `Pull Request` isteği ile göndermeyi unutmayın. Peki en basiti bu url bilgilerini veya izlendiğimizi nasıl anlayacağız.

### Bunun dışında nasıl yardım edebilirim?

Okuduğunuz mail bir şirket, kurum veya kuruluştan birisi tarafından bir e-posta alırsanız, kaynağa (*) bakın ve yukarıdaki kod gibi bir şeyler bulmaya çalışın. Genellikle postanın sonunda bulunur.

Aynı şekilde thunderbird kullanıyorsanız mailin kaynağına bakın kaynakta en sonra `click` ve(veya) `open` şeklinde yönlendirmelerde görebilirsiniz. Bu yönlendirmelere karşılık gelen domain bilgilerini bize gönderebilirsiniz.