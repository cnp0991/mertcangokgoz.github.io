---
layout: post
title: Linux'de Kullanıcı Gruplarının Düzeltilmesi
date: 2017-02-04
type: post
categories: linux
description: Dün gece ben birkaç ayarlama yaparken yanlışlıkla kullanıcıya grup tanımlaması yapmak yerine kullanıcıyı tek bir gruba atamak gibi bir hataya düştüm
---

Dün gece ben birkaç ayarlama yaparken yanlışlıkla kullanıcıya grup tanımlaması yapmak yerine kullanıcıyı tek bir gruba atamak gibi bir hataya düştüm. Gecenin 5 inde böyle bir hatayı yapma nedenim sanırım uykusuzluk bilemiyorum ancak var olan kullanıcıda hangi grup rollerinin olduğunu hatırlamak oldukça güç ne yapsam bu sorunun üstesinden gelirim diye düşündüm.

ama ilk önce güzel bir uyku uyumam gerekiyordu yoksa akıllıca bir hamle yapamayacaktım. Sabah kalktığımda ilk iş logları kurcalamak oldu kurulum sırasındaki loglar haliyle sistemde duruyordu çünkü

```
sudo grep user-setup /var/log/installer/syslog
```

Komutunu verdim `user-setup` ilk kullanıcı oluşturulduğunda loglar arasına güzel bir kayıt bırakıyor çünkü çıktısı da şu şekilde

```
Sep 23 21:41:05 anna[2534]: DEBUG: retrieving user-setup-udeb 1.64
Sep 23 21:41:36 main-menu[450]: INFO: Menu item 'user-setup-udeb' selected
Sep 23 23:24:52 finish-install: info: Running /usr/lib/finish-install.d/06user-setup
Sep 23 23:24:52 user-setup: Shadow passwords are now on.
Sep 23 23:24:52 user-setup: Adding user `mertcan' ...
Sep 23 23:24:52 user-setup: Adding new group `mertcan' (1000) ...
Sep 23 23:24:52 user-setup: Adding new user `mertcan' (1000) with group `mertcan' ...
Sep 23 23:24:52 user-setup: Creating home directory `/home/mertcan' ...
Sep 23 23:24:52 user-setup: Copying files from `/etc/skel' ...
Sep 23 23:24:52 user-setup: Adding user `mertcan' to group `audio' ...
Sep 23 23:24:52 user-setup: Adding user mertcan to group audio
Sep 23 23:24:52 user-setup: Done.
Sep 23 23:24:52 user-setup: Adding user `mertcan' to group `cdrom' ...
Sep 23 23:24:52 user-setup: Adding user mertcan to group cdrom
Sep 23 23:24:52 user-setup: Done.
Sep 23 23:24:52 user-setup: Adding user `mertcan' to group `dip' ...
Sep 23 23:24:52 user-setup: Adding user mertcan to group dip
Sep 23 23:24:52 user-setup: Done.
Sep 23 23:24:52 user-setup: Adding user `mertcan' to group `floppy' ...
Sep 23 23:24:52 user-setup: Adding user mertcan to group floppy
Sep 23 23:24:52 user-setup: Done.
Sep 23 23:24:52 user-setup: Adding user `mertcan' to group `video' ...
Sep 23 23:24:52 user-setup: Adding user mertcan to group video
Sep 23 23:24:52 user-setup: Done.
Sep 23 23:24:52 user-setup: Adding user `mertcan' to group `plugdev' ...
Sep 23 23:24:52 user-setup: Adding user mertcan to group plugdev
Sep 23 23:24:52 user-setup: Done.
Sep 23 23:24:52 user-setup: Adding user `mertcan' to group `netdev' ...
Sep 23 23:24:52 user-setup: Adding user mertcan to group netdev
Sep 23 23:24:52 user-setup: Done.
Sep 23 23:24:52 user-setup: Adding user `mertcan' to group `scanner' ...
Sep 23 23:24:52 user-setup: Adding user mertcan to group scanner
Sep 23 23:24:52 user-setup: Done.
Sep 23 23:24:52 user-setup: Adding user `mertcan' to group `bluetooth' ...
Sep 23 23:24:52 user-setup: Adding user mertcan to group bluetooth
Sep 23 23:24:52 user-setup: Done.
Sep 23 23:24:52 user-setup: adduser: The group `debian-tor' does not exist.
Sep 23 23:24:52 user-setup: Adding user `mertcan' to group `lpadmin' ...
Sep 23 23:24:52 user-setup: Adding user mertcan to group lpadmin
Sep 23 23:24:52 user-setup: Done.
```
Şimdi burada pek çok default grubu öğrendik geriye bunları eklemeye ve varsa bir kaç tanede sizin kullandıklarını araya sıkıştırmaya

```
sudo usermod -G audio,cdrom,dip,floppy,video,plugdev,netdev,scanner,bluetooth,lpadmin,vboxusers mertcan
```

Şeklinde yapabilirsiniz buda bir yöntem ancak el ile eklemekten üşeniyorsanız bunu otomatize edebilirsiniz şöyle ki

```
grep "user-setup: Adding user mertcan to group" /var/log/installer/syslog | cut -d' ' -f11
```

`mertcan` denen kısıma kendi kullanıcı adınızı girmeyi unutmayın. Bunlar dışında kurtarma modundan da grupları geri getirebilirsiniz ancak pek gerek yok sistemde hangi grupların olduğunu ise aşağıdaki linkten öğrenebilirsiniz. Açıklamaları ile birlikte bulunuyor.

[SystemGroups](https://wiki.debian.org/SystemGroups)