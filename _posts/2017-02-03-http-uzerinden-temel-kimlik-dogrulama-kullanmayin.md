---
layout: post
title: HTTP üzerinden Temel Kimlik Doğrulama kullanmayın
date: 2017-02-03
type: post
categories: guvenlik
description: Temel kimlik doğrulama, uygulamanın basitliği ve kolaylığı nedeniyle son derece popüler bir kimlik doğrulama aracıdır. Maalesef, HTTP üzerinden 
---

Temel kimlik doğrulama, uygulamanın basitliği ve kolaylığı nedeniyle son derece popüler bir kimlik doğrulama aracıdır. Maalesef, HTTP üzerinden aynı zamanda, kişilerin kimlik doğrulamalarını sağlamak güzel bir yöntem değildir! Temel kimlik doğrulama, istemcilerin kullanıcı adı ve parola kimlik bilgilerini iletmek için kimlik doğrulama HTTP başlık bilgisini(header) kullanır. İstemci verilen kullanıcı adını ve parolayı alır, **base64** olarak her ikisini de kodlar ve bir sunucuya istekte bulunurken bunları HTTP başlık bilgisine(header) ekler. Buraya kadar bir sorun yok hatta bu durum size normal bile geliyor olabilir.

```
GET /admin-panel HTTP/1.1
Authentication: Basic ZGVtbzpleGFtcGxl
Host: mertcangokgoz.com
```

Sunucu, doğrulama yapmak için kullanıcı adı ve parolanızı alır ve kimlik doğrulama başlık bilgisini(header) basitçe **base64** halini çözer. Sonuç olarak kişi benim doküman sistemime ulaşır. Maalesef, yukarıda belirttiğim gibi temel kimlik doğrulama **HTTP** protokolü üzerinden hiçbir zaman kullanılmamalıdır.

HTTP protokolü, daha akıllı kardeşi olan HTTPS'den farklı olarak **şifrelenmez**. Bu da internette bulunan herkesin gönderdiğiniz her ne olursa olsun görebildiğini varsayabileceğimiz anlamına gelir. Doküman koleksiyonum hassas bilgi değilken, isteği yaptığımda kimlik doğrulama başlığında benim kimlik bilgilerimi göndermiş oldum; bu da benim kimlik bilgilerimi kötü niyetli bilgisayar korsanlarına veriyor olabileceğim anlamına geliyor, çünkü  şifrelenmemiş istek ile yapılan bu işlem oldukça kolay bir şekilde istismar edilebilir.

İster aynı kafede oturuyor olun isterseniz dünyanın bir ucunda olun, kimlik bilgileriniz **HTTPS** dışında tamamen görülebileceği gibi kolayca parlolalarınız çözülecektir **Base64** bir şifreleme aracı kesinlikle değildir! Bu nedenle **HTTP** üzerinden temel kimlik doğrulamasını asla kullanmamalısınız! temel kimlik doğrulama yalnızca **HTTPS** üzerinden düşünülmeli ve kullanılmalıdır.

Peki HTTPS üzerinden kullanılan temel kimlik doğrulama işlemi yeterlimidir ?

Aslında hayır. Ama bu durum gerçekten sitenizin neye ve ne kadar güvenli olması durumuna bağlıdır. Parola her istek için tekrar tekrar gönderilebilir. Parola, web tarayıcısı tarafından, en azından işlem uzunluğu boyunca ön belleğe alınır. Buda sunucuya yapılan başka herhangi bir istekle sessizce yeniden kullanılabilir olabileceği anlamına gelir.

**HTTPS** kullanılması durumu bunlardan sadece bir tanesini çözer. Yani web sunucusundan istek gelene kadar korur herhangi bir iç yönlendirme, sunucu log vb. alanlarda parolalarınız düz metin olarak gözükür.