---
layout: post
title: Dell N4032F Switch İçin Stack Ayarlama
date: 2017-04-20
type: post
categories: network
description: Geçenlerde yeni kurulum için bir takım konfigürasyon işleri yaparken Dell marka N4032F model 2 adet switch elimize geçti konfigürasyonlar
---

Geçenlerde yeni kurulum için bir takım konfigürasyon işleri yaparken Dell marka N4032F model 2 adet switch elimize geçti konfigürasyonlar olarak ciscoya her ne kadar benzesede biraz farklı geldi ancak işin içinden çıkmayı güzelce başardık.

Ayrıca Stack yapılacak switchlerin her ikisininde aynı sürüm yazılım kullanması ve desteklenen modellerden birinin olması gerekiyor. Bunu görmek için;

```
show supported
```

Baktık sürümler ve cihazlar stack destekliyor. Stack işlemini yapalımda kurtulalım dedik bu sırada 1Ge lik portlardan yanıt almak istedik dokümantasyondada bu adamlar bize demiyor ki kardeş siz sadece 10Ge lik portlardan stack yapabilirsiniz. Bizde 2 saatimizi 1Ge olan cibikler üzerinden yapmaya çalışıyoruz.

Neyse yemek yedikten sonra aklımıza dank etti de sonradan dokümantasyonda gördük akıl ettik fiberini taktık ve oldu, böyle dediğime bakmayın gene dokümantasyonda şöyle yapın dememiş 

Herneyse master belirlememiz gerekiyor biliyorsunuz. Bunun için cihaz Mac adresi en büyük olanı seçiyor olması lazım yani sizin MAC adresi büyük olan switchi ayarlamanız gerekiyor. Bunun için ise;

```
config
stack
stack-port tengigabitethernet 1/0/23 stack
stack-port tengigabitethernet 1/0/24 stack
```

bu işlemden sonra direk olarak ikinci switch ede aynı konfigürasyonu eklemeniz gerekiyor. Daha sonra direk olarak `do reload` her iki yada kaç tane switch konfigure ediyorsanız yeniden başlatırsanız. Otomatik olarak kendisi stack olacak ve ayarlamaya ve konfigürasyonunu senkronize etmeye başlayacak ve hangisinin MAC adresi yüksek ise sadece ondan ayarlanmak üzere diğer switchleri düzenleyecek

Daha sonra yapmanız gereken ek ne kadar ayar yapılacak ise onu yapmak vlan ayarlamak ip vermek ve bağlantı ekipmanlarını ayağa kaldırmak olacak.

tabi stack olup olmadığını görmek için

```
show switch
```

komutunu verebilirsiniz direk olarak burada stack olan ve master olan switch görmeniz gerekecek

Tabi son olarak ayarları kayıt etmeyi unutmayın sonra çok uğraşırsınız. Kaydetmek için ise

```
write
```