---
layout: post
title: Debian İçin Samba Ayarlanması İşlemi
date: 2017-02-16
type: post
categories: linux
description: Evde bulunan bilgisayarlar ile benim ana bilgisayarım arasında dosya transferi için USB kullanıyorduk. Bize vakit kaybettirdiğiniz düşündüğüm
---

Evde bulunan bilgisayarlar ile benim ana bilgisayarım arasında dosya transferi için USB kullanıyorduk. Bize vakit kaybettirdiğiniz düşündüğüm için bende samba kurayım da bu sorunu ortadan kaldırayım diye düşündüm. Öncelikli olarak sambanın gerekli olan tüm kütüphanelerini aşağıdaki müzik ile kurmaya başladım.

<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/K_fcvT_SLVg?list=PLcWykhEQl68Zk5Ws9FfhQzsMo1NH5k9Ns" frameborder="0" allowfullscreen></iframe>

"Müzik ruhun gıdasıdır" derler gerçekten de öyledir. siz bir şeyleri yaparken sizi dinlendirmesi oldukça güzeldir. Ben bu işlemleri gecenin 4 ünde yapıyordum.

```
apt-get -y install samba 
```

Gerekli olan paketleri `apt` kardeş bir güzel kuruyor. Şimdi geldim konfigürasyonlara oldukça basit ancak sistematik ilerliyoruz. Hem kafanızın karışmaması için hemde düzen iyidir.

İlk önce dizinleri oluşturup izinleri veriyoruz ayrıca bu iş için yenide bir grup oluşturdum ben 

```
groupadd samba-user 
mkdir /home/mertcan/samba-dosyalar 
chgrp samba-user /home/mertcan/samba-dosyalar 
chmod 770 /home/mertcan/samba-dosyalar
```

Şimdi bizim ana konfigürasyon dosyamız içerisinde `/etc/samba/smb.conf` değişiklik yapacağız bunlar şu şekilde olacak

Karakter setini tanımlayalım

```
unix charset = UTF-8
```

Çalışma alanı adı tanımlayalım

```
workgroup = WORKGROUP
```

Kabul edilecek ip adreslerini network bazında

```
interfaces = 127.0.0.0/8 192.0.0.0/24
```

Sadece `interfaces` kullanılsın diye eklememizi yapalım

```
bind interfaces only = yes
```

Şimdi geldik en güzel noktaya bu alanda sambada kullanılacak olan dosyayı ve izinlerini ayarlıyoruz.

```
[Dosyalar]
   comment = Dosyalar
   path = /home/mertcan/samba-dosyalar
   writable = yes
   create mode = 0770
   directory mode = 0770
   share modes = yes
   guest ok = no
   read only = no
   locking = no
   valid users = @samba-user
```

Kullanılacak olan kullanıcı için sambada şifre tanımlıyoruz.

```
smbpasswd -a mertcan 
```

Kullanıcı için kullanılacak olan grubu ekliyoruz. Burada benim gibi hata yaparsanız. [Linux'de Kullanıcı Gruplarının Düzeltilmesi](https://mertcangokgoz.com/linuxde-kullanici-gruplarinin-duzeltilmesi/) makalesi aracılığı ile sorununuzu giderebilirsiniz.

```
usermod -aG samba-user mertcan
```

Tüm işlemler bitti ise samba servisini yeniden başlatabilirsiniz. Hadi geçmiş olsun samba yapılandırmanız tamamdır.

```
/usr/sbin/service smbd restart 
```

Kapanışı da aşağıdaki müzik ile yapıyoruz.

<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/DK5CqIKzUyw?list=PLcWykhEQl68Zk5Ws9FfhQzsMo1NH5k9Ns" frameborder="0" allowfullscreen></iframe>