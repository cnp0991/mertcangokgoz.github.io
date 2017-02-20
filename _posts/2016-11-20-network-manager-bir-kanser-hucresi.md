---
layout: post
title: Network Manager Bir Kanser Hücresi
date: 2016-11-20
type: post
categories: linux
description: Evet uzun bir aradan sonra tekrar beraberiz ilginç bir durum ile karşınızdayım vizelerin bitmesini fırsat bilip Onur ile birlikte unbound + DNSCrypt
---

Evet uzun bir aradan sonra tekrar beraberiz ilginç bir durum ile karşınızdayım vizelerin bitmesini fırsat bilip Onur ile birlikte unbound + DNSCrypt kurmaya karar verdim onun konfigürasyon dosyaları oldukça işime yaradı ancak bir noktada bizi çileden çıkarttı

network manager = **kanser**

Evet bu konuda Onur'un dediği gibi bunu fark etmem haliyle geç oldu kolaylık sağlıyor. Dursun dedik destek yerine köstek oldu bu kadarda olmaz bir DNS ayarlaması zulüm oldu

Şimdi olayı bana yaşatan lokal dns server kurulumundan sonra DNS kayıtlarını güncellerken network-manager kardeşin hala modemdeki dnsyi almasıydı

Biraz uğraştırdı bizi bir kaç yerden ayarlama yapmamız ve bu lanet olası şeyi kaldırmamız gerekti öncelikle debian kullanıyorum bunu belirteyim sizlere

```
apt purge network-manager network-manager-gnome
```

İlk olarak güzelce bir sildim şu boku reboot falan atarsanız internetiniz olmayacak bunu biliyorsunuz ama **interfaces** kardeşi kullanıcaz ne gerek var network managere ya gereksiz

Ben dizüstü bilgisayar kullanıyorum her ne kadar wifi ye pek bağlanmıyor olsam da bu yüzden direk olarak kablolu bağlantıya göre interneti ayarlıyorum. `uydunet network` yazan benim kablolu bağlantım güzel bir şekilde otomatiğe aldık ve dhcp den çeksin istedik

```
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# Uydunet Network
allow-hotplug enp4s0
iface enp4s0 inet dhcp

# Wifi NetMASTER Uydunet-AD66
allow-hotplug wlp3s0
iface wlp3s0 inet dhcp
	wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
```

Şimdi bu yaptığımıza göre otomatik olarak ipleri alıp dnsleri girecek bu girdikleri modemin DNS bilgileri olacak bunu engellemek için ise

```
nano /etc/dhcp/dhclient.conf
```

içerisinde DNS değişkenine almasını istediğimiz değeri şu şekilde tanımlatıyoruz. Ben local DNS server ip adresini girdim. Siz böyle bir şey yapmayacaksanız kullanmak istediğinizi yazın

```
prepend domain-name-servers 127.0.0.69;
```

Kayıt edip çıkıyoruz. Sisteminiz güzelce internete çıkmış olacak network manager denen uygulamadan kurtulmuş olacaksınız. Peki wifi bağlanmak istediniz ne olacak tabikide zor değil

İlk önce aşağıdaki komut aracılığı ile ney olduğunu bi öğrenin bende `wlp3s0` olduğu için ayarlamalarımızı ona göre yapıyorum.

```
ip a
iwconfig
ip link set wlp3s0 up
```

tabi bundan önce ben rfkill ile kapattığım için onu açtım bunu FN tuş kombinasyonları ile yapabildiğim için ek bir şey kullanmaya gerek duymadım.

Wifi donanımımız açıldıktan sonra ise tarama işlemi yapalım çalışıyormu diye kontrol edelim.

```
iwlist scan
```

Tarama sonucunda bana en yakın olanı şu şekilde ortaya çıktı

```
          Cell 01 - Address: 18:28:61:E9:81:2C
                    Channel:3
                    Frequency:2.422 GHz (Channel 3)
                    Quality=42/70  Signal level=-68 dBm
                    Encryption key:on
                    ESSID:"NetMASTER Uydunet-AD66"
                    Bit Rates:1 Mb/s; 2 Mb/s; 5.5 Mb/s; 11 Mb/s; 18 Mb/s
                              24 Mb/s; 36 Mb/s; 54 Mb/s
                    Bit Rates:6 Mb/s; 9 Mb/s; 12 Mb/s; 48 Mb/s
                    Mode:Master
                    Extra:tsf=0000006a5171b0ce
                    Extra: Last beacon: 2680ms ago
                    IE: Unknown: 001A54544E45545F416972546965735F416972353635305F33423334
                    IE: Unknown: 010882848B962430486C
                    IE: Unknown: 030103
                    IE: Unknown: 2A0100
                    IE: Unknown: 2F0100
                    IE: IEEE 802.11i/WPA2 Version 1
                        Group Cipher : TKIP
                        Pairwise Ciphers (2) : CCMP TKIP
                        Authentication Suites (1) : PSK
                    IE: Unknown: 32040C121860
                    IE: Unknown: 2D1A7C181BFFFF000000000000000000000000000000000000000000
                    IE: Unknown: 3D1603080400000000000000000000000000000000000000
                    IE: Unknown: 4A0E14000A002C01C800140005001900
                    IE: Unknown: 7F0101
                    IE: Unknown: DD0B001CA8500101E9812C2B03
                    IE: Unknown: DDBF0050F204104A0001101044000102103B00010310470010B3FC5511C0F23C7342D547F8479E486C102100194169725469657320576972656C657373204E6574776F726B731023000941697235363530545410240007312E302E332E311042000F4154313633313430363031323830381054000800060050F204000110110009416972353635305454100800022008103C0001011049000600372A0001201049001E007FC51000180B5947706C78D38CB60DA7971E68D5D93030303030363339
                    IE: Unknown: DD090010180202F02C0000
                    IE: WPA Version 1
                        Group Cipher : TKIP
                        Pairwise Ciphers (2) : CCMP TKIP
                        Authentication Suites (1) : PSK
                    IE: Unknown: DD180050F2020101800003A4000027A4000042435E0062322F00
```

Cihaz hakkında bilgileri görebilirsiniz. Şimdi bağlanmak istediğimiz bu olsun şu şekilde bir ayarlama yapmamız gerekiyor.

```
nano /etc/network/interfaces
```

İçerisine yukardaki kablolu bağlantıda yaptığımız gibi ayarlamayı yapıyoruz.

```
# Wifi NetMASTER Uydunet-AD66
auto wlp3s0
iface wlp3s0 inet dhcp
	wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
```

peki bahsi geçen konfigürasyon dosyasında ne var

```
root@0x2e88ce4:/etc/wpa_supplicant# cat wpa_supplicant.conf
# Netmaster Uydunet-AD66
network={
	ssid="NetMASTER Uydunet-AD66"
	#psk="a21a33075f5e6aa3"
	psk=06218cc6a5eae69640972f074827caceaa1502cc49bf42327fbe2c8ffb40fd62
}
```

Çalıştığını `dmesg` sorgusunun çıktısına bakarak anlayabiliriz `authenticated` olmuş ve bağlantı sağlanmış. Ayrıca nete girip girmediği durumu ile de anlayabilirsiniz.

```
[  901.276010] wlp3s0: authenticate with 00:1c:7b:cc:b3:54
[  901.279214] wlp3s0: send auth to 00:1c:7b:cc:b3:54 (try 1/3)
[  901.281124] wlp3s0: authenticated
[  901.284657] wlp3s0: associate with 00:1c:7b:cc:b3:54 (try 1/3)
[  901.287733] wlp3s0: RX AssocResp from 00:1c:7b:cc:b3:54 (capab=0x1411 status=0 aid=3)
[  901.289250] wlp3s0: associated
```

Kayıt edip çıkışınızı yapıyorsunuz. İsterseniz networkü isterseniz de sistemi yeniden başlatarak ayarlarınızın geçerli olmasını sağlayabilirsiniz.

Birden çok wifi tanımlayabilirsiniz. Hangisine bağlanacak yada bağlanacağım diyorsanız da bunu kendisi otomatik olarak seçiyor bu seçimi yaparken de çekim gücü en iyi olana göre yapıyor.

Bu işlem ile lanet olası network-manager uygulamasından hem kurtulmuş oluyorsunuz hemde rahat rahat işiniz gücünüze bakabiliyorsunuz. Sorun yaratan sıkıntı çıkartan bir uygulama artık yok

Aldığım saçma salak hataların çözümü için [Onur Aslan](https://onur.im/) Teşekkür ederim.

öptüm bye <3
