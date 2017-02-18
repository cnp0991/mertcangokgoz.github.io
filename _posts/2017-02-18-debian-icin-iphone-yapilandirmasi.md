---
layout: post
title: Debian için İphone Yapılandırması
date: 2017-02-18
type: post
categories: linux
description: İOS(iPhone, iPod Touch, iPad, Apple TV) cihazlar bilindiği gibi direk olarak USB ile takılıp herhangi bir şekilde içerisindeki dosyalar alınamıyor yada
---

İOS(iPhone, iPod Touch, iPad, Apple TV) cihazlar bilindiği gibi direk olarak USB ile takılıp herhangi bir şekilde içerisindeki dosyalar alınamıyor yada içerisine dosya atılabiliyor. Bende bir İphone kullanıcısı olarak bu soruna bir çözüm getirmek istiyorum. Bunun için aşağıdaki parçayı seçtim

<iframe width="640" height="360" src="https://www.youtube-nocookie.com/embed/PHo5U9Rios0" frameborder="0" allowfullscreen></iframe>

Gerekli olan paketlerin kurulumunu yapıyoruz.

```
aptitude install libimobiledevice-utils ipheth-utils ideviceinstaller libimobiledevice-dev gvfs-backends gvfs-bin gvfs-fuse
```

Şimdi bu kurduklarımız içerisinde Telefonu modem olarak kullanmamıza yarayacak ekipman ile telefonu sisteme mount edebilmemize imkan sağlayan `libimobiledevice` kadar tüm her şey var. 

Şimdi kurulum tamamlandıktan sonra `/etc/fuse.conf` yoluna geçiş yapıyoruz ve `root` kullanıcı izinleri ile aşağıdaki değişikliği yapıyoruz.

```
 #user_allow_other
```

Olarak gözüken satırın başında bulunan `#` kaldırıp kayıt ediyoruz. İşlemimiz tamamlanıyor. Şimdi sistemimizi zorunlu yeniden başlatmamız gerekiyor.

```
sudo reboot -h now
```

Yeniden cihaz açıldığında direk olarak telefonunuzu elinize alıyorsunuz ve USB den bağlıyorsunuz. Ekranda bir anda güven yada güvenme diye bir ekran beliriyor. Sizde hemen o ekranda gördüğünüz `Güven` butonuna basıyorsunuz. İşlem böylelikle son buluyor.

Artık sorunsuz bir şekilde telefonunuz sisteme mount edilmiş oluyor.

Kernel mesajlarında ise şu şekilde gözüküyor durum

```
[   56.437823] usb 3-3: new high-speed USB device number 4 using xhci_hcd
[   56.579739] usb 3-3: New USB device found, idVendor=05ac, idProduct=12a8
[   56.579741] usb 3-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   56.579742] usb 3-3: Product: iPhone
[   56.579742] usb 3-3: Manufacturer: Apple Inc.
[   56.579743] usb 3-3: SerialNumber: 9ea3cfff5882e13a769878222151625db5a5cdc0
[   56.606852] ipheth 3-3:4.2: Apple iPhone USB Ethernet device attached
[   56.606868] usbcore: registered new interface driver ipheth
[   56.608989] ipheth 3-3:4.2 enp0s20u3c4i2: renamed from eth0
```

Yukarıdaki mesaj ile aynı zamanda cihazımızın modem olarak da kullanılabileceğini görmüş oluyoruz. Bu özelliği kullanabilmek için ise `Internet Tethering` özelliğini kullanacaksınız artık onuda sistemden arayıp bulabilirsiniz. Genelde zaten otomatik network tarafında gözüküyor.

Peki ya kullanmıyorsak ? yani network için herhangi bir grafik ara yüzümüz yok ve `Internet Tethering` yapılandırmamız gerekiyorsa ne yapacağız.

Bunun için ilk `root` izinleri ile `/etc/udev/rules.d/90-iphone-tethering.rules` olarak kural girmemiz gerekiyor.

```
ACTION=="add|remove", SUBSYSTEM=="net", ATTR{idVendor}=="05ac", ENV{ID_USB_DRIVER}=="ipheth", SYMLINK+="iPhone", RUN+="/usr/bin/systemctl restart systemd-networkd.service"
```

Yukarda diyoruz ki Vendor kodu `05ac` ile gelen ve sürücü olarak `ipheth` kullanan aynı zamanda `iPhone` olan bir şey gelirse networkd kardeşin servisini benim belirttiğim şekilde yeniden başlat

Şimdi gereken kural setinin son aşamasında `/etc/systemd/network/` yoluna gidelim ve şunları yapalım

```
sudo nano enp0s20u3c4i2.network
```

Ve içerisini şu şekilde düzenleyelim.

```
[Match]
Name=enp0s20u3c4i2

[Network]
DHCP=ipv4
```

Burada da adı `enp0s20u3c4i2` ile eşleşiyor ise networkden ipv4 aracılığı ile otomatik ip alma işlemini yap. Bu tüm işlemler son bulduğunda otomatik olarak İphoneyi her taktığınızda eğer iphonede tethering açık ise modem olarak bağlar. 