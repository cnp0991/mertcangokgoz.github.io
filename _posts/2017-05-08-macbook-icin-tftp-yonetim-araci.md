---
layout: post
title: Macbook İçin TFTP Yönetim Aracı
date: 2017-05-08
type: post
categories: macos
description: Macbook içerisinde build-in olarak gelen güzel bir tftp uygulaması bulunuyor. Yapmış olduğum bu betik ile de bağlantı
commentid: 10
---

Macbook içerisinde build-in olarak gelen güzel bir tftp uygulaması bulunuyor. Yapmış olduğum bu betik ile de bağlantı işlemlerini yani TFTP server işlemlerini kolaylaştırmaya çalıştım. Firmware yükleme işlemlerinde oldukça kolaylık sağlaması için yaptım gerçekten de işe yarıyor.

Neyse uzatmayalım kodu paylaşalım. Dialog kullandım çünkü birazda olsa güzel görünmesi benimde hakkım Kayıp paket yöneticimiz olan homebrew ile `dialog` paketini kurmayı unutmayın.

```
brew install dialog
```

Ardından hiç bir şey olmamış gibi uygulamayı çalıştırıp kullanabilirsiniz.

```
chmod +x tftpServer.sh
./tftpServer.sh
```

{% gist MertcanGokgoz/6388668bfebf2ceeb9c2e1cb6f10c9f9 %}