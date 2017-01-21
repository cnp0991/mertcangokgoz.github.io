---
layout: post
title: Siberyildiz Soru ve Cevaplar
date: 2017-01-21
type: post
categories: guvenlik
description: Merhaba arkadaşlar bilindiği gibi **USOM** aracılığı ile bir **CTF** düzenlendi ve bizde buna katılma ihtiyacı duyduk. Bizler ne etik hackerız nede bu alanda çalışıyoruz. Biz sadece programlama
---

Merhaba arkadaşlar bilindiği gibi **USOM** aracılığı ile bir **CTF** düzenlendi ve bizde buna katılma ihtiyacı duyduk. Bizler ne etik hackerız nede bu alanda çalışıyoruz. Biz sadece programlama ve bir takım bilgiler ile CTF'ler de neler yapabileceğimize bakıyoruz.

**CTF** başladığında haliyle siteye girip soruları çözemedik bunda en büyük etken yarışma başladığında kurumun hiçbir şekilde Anti-ddos araçları ile siteyi korumamış olması ayrıca sistemin düzgün çalışmaması neyse her yerde olabilir vs deyip bir kaç soruya girebildik ve çözmeye başladık

Ancak belirtmek istiyorum. Oldukça fazla bir şekilde cevap paylaşımı ve çoklu grup kafası yüzünden ciddi anlamda geçerliliği sorgulanması gerekiyor üstelik bu yarışma yaklaşık 6 Saat kadar bir süre saldırı kaynaklı kesintiye uğradı ve bizde dahil cevaplarımızı giremedik

Sisteme giriş yaptığımızda ise pek çok gurubun yüksek puanlara geçmiş olduğunu gördük. İnsanlarda haklı olarak twitter hesaplarından tepkide bulundular.

Soruların bazılarının cevaplarını yazacak vaktim olmadığı için **ilerleyen güncelerde makale güncellenecektir.**

**Soru 1**

*"İyi bak "* Bu soruda ilk olarak size bir adet resim veriyor ve bu resimden yola çıkarak cevabı bulmanız isteniyor. Resmi google aracılığı ile arattığımızda para ile alınmış olabileceğini düşündük ve biraz araştırma yaptık daha sonra basitten zora gidiyordur diye bi `exiftool` aracılığı ile comment ve copyright baktık ama soruda "iyi bak" dediği için daha sonrasında resme odaklandık

![siberyildizsoru1](/assets/soru1siberyildiz.jpg)

Her neyse resmin boş olduğunu anladıktan sonra curl atıp bakalım dedik birde ne görelim `FLAG` olarak orada bulunuyordu

![soru1cevap](/assets/soru1cevap.png)

```
335286429afb2a2344079fe68764a1e0
```

----------

**Soru 2**

*"Bakalım ne kadar iyisin ?"* Bu soruda ise basit bir login ekranı geliyor karşımıza ne kadar iyisin diyor sonrada bize ilk başta ekip olarak biz bi xss yada sql inj deneriz çünkü basitten zora gitmek gerekir biraz kurcaladıktan sonra altta yazan mesaja odaklandık kullanıcı adını bulmamız bu sayede zor olmadı :)

![siberyildizsoru2](/assets/soru2siberyildiz.png)

Kullanıcı adı: Yonetici<br>
Şifre: 1'or'1'='1

Olarak sisteme giriş yaptık

----------

**Soru 3**

*Yetkili bir kullanıcı ile giriş yapman lazım.* Sorusuna gelelim bu soruda ise sistemde zaten hali hazırda giriş yapmış olduğumuzu biliyoruz. Ancak bize daha yetkilisini bulmamızı söylüyor. Ve sayfa ilk giriş yaptığımızda bize çerez olarak

```
isAdmin=cfcd208495d565ef66e7dff9f98764da
```

Yukarıdaki yükleniyor hemen ardından ise çıkış yaptığımızda bu değeri sistemden siliyor. Biz bu değeri bir decode edelim dedik karşımıza `0` çıktı cevap haliyle bu olamazdı

----------

**Soru 4**

*"Elimizde bir flash bellek var, içerisindeki resimlerden biri bize lazım."* adlı sorumuza geldi sıra buradada bize verdiği dosya sözde bir disk imajı

```
ef2a36ae56f254dd6adf716dffc84264: DOS/MBR boot sector, code offset 0x52+2, OEM-ID "NTFS    ", sectors/cluster 8, Media descriptor 0xf8, sectors/track 62, heads 247, hidden sectors 2048, dos < 4.0 BootSector (0x80), FAT (1Y bit by descriptor); NTFS, sectors/track 62, sectors 102399, $MFT start cluster 4, $MFTMirror start cluster 6399, bytes/RecordSegment 2^(-1*246), clusters/index block 1, serial number 013e61d99342ea2e1; contains Microsoft Windows XP/VISTA bootloader BOOTMGR
```

Buraya kadar herşey normal şimdi sıra dosyaya `binwalk` ile bakmaya içerisinde neyin olup bittiğini görebileceğiz bu sayede

```
binwalk ef2a36ae56f254dd6adf716dffc84264 > dump.txt
```

Dosya içerisinde birden fazla PDF ve Resim olduğunu görüyoruz. Şimdi bunları dd ile tek tek çıkartmaya geldi

```
dd if=ef2a36ae56f254dd6adf716dffc84264 of=new.jpeg skip=14433399 bs=1
dd if=ef2a36ae56f254dd6adf716dffc84264 of=new2.jpeg skip=14516838 bs=1
dd if=ef2a36ae56f254dd6adf716dffc84264 of=new3.jpeg skip=28406368 bs=1
dd if=ef2a36ae56f254dd6adf716dffc84264 of=new4.jpeg skip=29052314 bs=1
dd if=ef2a36ae56f254dd6adf716dffc84264 of=new5.jpeg skip=29241403 bs=1
dd if=ef2a36ae56f254dd6adf716dffc84264 of=new6.jpeg skip=33026056 bs=1
dd if=ef2a36ae56f254dd6adf716dffc84264 of=new7.jpeg skip=33062920 bs=1
dd if=ef2a36ae56f254dd6adf716dffc84264 of=new8.jpeg skip=33062950 bs=1
dd if=ef2a36ae56f254dd6adf716dffc84264 of=new9.tiff skip=33062950 bs=1
dd if=ef2a36ae56f254dd6adf716dffc84264 of=new0.jpeg skip=45166530 bs=1
dd if=ef2a36ae56f254dd6adf716dffc84264 of=new11.jpeg skip=49163867 bs=1
dd if=ef2a36ae56f254dd6adf716dffc84264 of=new12.jpeg skip=49279925 bs=1
```

Çıkarttığımız resimler içerisinde benim dikkatimi en fazla çeken usomun logosunun bulunduğu ve resim headeri bozuk olandı

Herhangi bir hex aracı ile resmi açıyorsunuz ve header bilgisini düzeltiyorsunuz uzun uzun anlatmayacağım mantığını şu site aracılığı ile öğrenebilirsiniz. [Rebuilding an Image Header](https://samsclass.info/121/proj/p7-image-header.htm)

Daha sonra resmi düzelttikten hemen sonra herhangi bir exif aracı ile ki ben "exiftool" seçtim bilgilere bakıyoruz.

```
mertcan@0x2e88ce4:~/Desktop$ exiftool exifusom.png
ExifTool Version Number         : 10.37
File Name                       : exifusom.png
Directory                       : .
File Size                       : 87 kB
File Modification Date/Time     : 2017:01:21 14:23:12+03:00
File Access Date/Time           : 2017:01:21 14:23:20+03:00
File Inode Change Date/Time     : 2017:01:21 14:23:26+03:00
File Permissions                : rw-r--r--
File Type                       : PNG
File Type Extension             : png
MIME Type                       : image/png
Image Width                     : 962
Image Height                    : 421
Bit Depth                       : 8
Color Type                      : RGB with Alpha
Compression                     : Deflate/Inflate
Filter                          : Adaptive
Interlace                       : Noninterlaced
Exif Byte Order                 : Little-endian (Intel, II)
Copyright                       : D0sy4kurt4rmA_B1ziM-1$iM1Z
Thumbnail Offset                : 94
Thumbnail Length                : 3755
Pixels Per Unit X               : 11811
Pixels Per Unit Y               : 11811
Pixel Units                     : meters
Software                        : Adobe ImageReady
Warning                         : Truncated PNG image
Image Size                      : 962x421
Megapixels                      : 0.405
Thumbnail Image                 : (Binary data 3755 bytes, use -b option to extract)
```

Ve sonunda bayrağımıza ulaştık

```
Copyright                       : D0sy4kurt4rmA_B1ziM-1$iM1Z
```

Değerin md5 hash halini alıyoruz ve işlemimiz burada bitiyor.

```
0679ce1ac69b580a695fc8308bfd2116
```

----------

**Soru 5**

"Parolayı bul ve bize gönder !" başlıklı bu soruda ise bize site içerisinde kaynakta gözükecek şekilde obfuscate edilmiş yani karıştırılmış bir JS kodu verilmiş ve bizden bunu çözmemiz isteniyor. İlk olarak kodu düzeltelim

```
$(document)['ready'](function() {
    $('#loginform')['submit'](function(_0x34b0x1) {
        _0x34b0x1['preventDefault']();
        var _0x34b0x2 = true;
        var _0x34b0x3 = $('input[name="username"]')['val']();
        var _0x34b0x4 = $('input[name="password"]')['val']();
        var _0x34b0x5 = new Array('b5', '1c44', 'c6', '24c1', 'e6', '2b93', 'da', '1fd4', 'b1');
        if (CryptoJS.MD5(_0x34b0x3).toString() === '2dfa843b02427819d8bdf8271bb84a3c' && _0x34b0x4['length'] === (18 / 3 + 6 - 3)) {
            for (i = 0; i < _0x34b0x3['length']; i++) {
                if (i % 2 === 0) {
                    if (((_0x34b0x3['charAt'](i)['charCodeAt'](0)) + (_0x34b0x4['charAt'](i)['charCodeAt'](0))).toString(16) !== _0x34b0x5[i]) {
                        _0x34b0x2 = false;
                        break;
                    }
                } else {
                    if (_0x34b0x5[i] !== ((_0x34b0x3['charAt'](i)['charCodeAt'](0)) * (_0x34b0x4['charAt'](i)['charCodeAt'](0))).toString(16)) {
                        _0x34b0x2 = false;
                        break;
                    }
                }
            };
            if (_0x34b0x2) {
                alert('Ba\u015Far\u0131l\u0131 i\u015Flem')
            } else {
                alert('Hatal\u0131 i\u015Flem')
            };
        } else {
            alert('Kullan\u0131c\u0131 ad\u0131 veya \u015Fifre yanl\u0131\u015F')
        };
    })
});
```

Şimdi bu düzelttiğimiz kodların içerisinde yukarıda bulunan ve benim dahil etmediğim bir var bulunuyor çünkü bunun içerisinde sadece kullanıcı adı bulunuyordu oda md5 formatında verilmişti.

`2dfa843b02427819d8bdf8271bb84a3c`

Şimdi burada belirlememiz gereken tek şey şifre idi koda baktığımızda kullanıcı adının uzunluğunun 8 şifrenin ise 9 olması gerektiği idi bunu attık kenara zaten kullanıcı adı "alpaslan" yani md5 değerinin çözülmüş hali idi

Şifreyi çözmek içinse şöyle bir yol izlendi

```
##Adım 1 -
_0x4831 HEX  > ASCII
"""
input[name="username"]
input[name="password"]
b5
1c44
c6
24c1
e6
2b93
da
1fd4
b1
2dfa843b02427819d8bdf8271bb84a3c
length
charCodeAt
charAt
Başarılı işlem
Hatalı işlem
Kullanıcı adı veya şix66re yanlış
submit
#loginform
ready
##Adım2
_0x4831[13] > MD5 Crack > alparslan

##Adım 3
_0x34b0x5  > HEX > Decimal
181
7236
198
9409
230
11155
218
8148
177

##Adım 4
alparslan > Stplit Keys > Char Code
97
108
112
97
114
115
108
97
110

##Adım 5
a-b OR a/b  > Char
181-97=84 T
7236/108= C
198-112=86 V
9409-97=97 a
230-114=116 t
11155/115=97 a
218-108=110 n
8148/97=84 T
177-110=67 C
```

Şifre olarak ise çözümlemeler sonucunda uzunluğu 9 olan bir şifre elde ettik `TCVatanTC` Ayrıca sayfanın title baktığımızda BS yazdığını da gördük yani alpaslan demek istediği Büyük Selçuklu olabilirdi yada bi s.... git diyerek küfür ediyo da olabilirdi ancak sonuca ulaşabilmiştir.

```
d66ab2522c55a041661ff6526c99c36d
```

----------

**Soru 6**

"Holowy Conz den beklediğimiz mesaj geldi, acaba nedir ?" olarak karşımıza bir resim çıkıyor. Haliyle bu bir steghide sorusu zorlanacağımızı düşündüysek de 10 sn kadar bir süre aldı çözmemiz

![siberyildizsoru6](/assets/soru6gorsel.png)

Herhangi bir unhide sitesine giriyoruz ve resmi siteye yüklüyoruz. Bu iş için biz [Image Steganography](http://incoherency.co.uk/image-steganography/#unhide) sitesini kullandık sonuç olarak bize aşağıdaki gibi bir çıktı geldi ve hemen bir barkod okuyucu ile cevabı aldık

![siberyildizsoru6cevap](/assets/soru6cevap.jpg)

ve sonuç olarak kare barkod da "siberstar" çıktı bunun md5 değerini alıyoruz.

```
0b6f6a0a8520da0839e5e3075df924fa
```

Ancak bu değer sistem tarafından kabul edilmiyor. Dosya içerisinde başka bir şekilde bulunuyor olma ihtimali yüksek

----------

**Soru 7**

*Algoritmada ne kadar hizlisin ?* Bu soruda bize sıralı bir dizi vermiş ve bizden sıralı olarak gidenleri bulmamızı istiyor.

```
Bir silsileden(sequence) sifir yada daha fazla eleman atilarak elde edilen silsileye alt silsile denir. Alt silsileler arasinda silsile elemanlari sirali olanlara sirali alt silsile denir. Ornegin (1,5,6,3,4,2,9,10,11) silsilesinden elden edilen (1,5) ve (2,9,10) birer sirali alt silsiledir. Ayni zamanda (2,9,10,11) silsilesi en fazla uyeye sahip sirali alt silsiledir. Buna gore asagida elemanlari onaltilik (hexadecimal) sayi sisteminde verilen silsilenin en fazla elemana sahip sirali alt silsilesi nedir.

Not: Cevap (1,25,216) formatinda (bosluksuz,virgullu ve parantezli) olmalidir. Elemanlar onluk (decimal) sayi sisteminde olmalidir.

Soru Silsilesi:
(0x9a,0x85,0x9e,0xac,0xaa,0xc4,0xa4,0xbb,0xbe,0x9a,0x64,0x9e,0x8e,0x9b,0x70,0xb4,0x81,0xa3,0x81,0x9b,0x9c,0x68,0x68,0x8b,0x6b,0x83,0x70,0x81,0xb2,0xb9,0x75,0xa7,0xb2,0x98,0x7a,0x90,0x92,0xc0,0xbf,0x64,0x75,0x68,0x7a,0xc5,0xa2,0xaa,0xab,0xc4,0x78,0x6c,0xab,0xbb,0xb5,0x7c,0x95,0xa4,0xb2,0x73,0x84,0xa0,0x88,0x96,0x72,0x8d,0xac,0x85,0xa7,0xad,0x82,0x9d,0xab,0x99,0x7c,0x72,0x6d,0x6b,0x8c,0x8a,0xa7,0x7d,0x68,0x86,0xaf,0xbb,0x79,0x83,0x8c,0x7b,0x72,0xb2,0x6f,0x77,0xb6,0xb8,0xf4,0xF6,0x8c,0x67,0xb6,0xb5)
```

Hex formatında verdiği içinde buna göre bazı işlemler yapmamız gerekiyordu haliyle

```
liste="0x9a,0x85,0x9e,0xac,0xaa,0xc4,0xa4,0xbb,0xbe,0x9a,0x64,0x9e,0x8e,0x9b,0x70,0xb4,0x81,0xa3,0x81,0x9b,0x9c,0x68,0x68,0x8b,0x6b,0x83,0x70,0x81,0xb2,0xb9,0x75,0xa7,0xb2,0x98,0x7a,0x90,0x92,0xc0,0xbf,0x64,0x75,0x68,0x7a,0xc5,0xa2,0xaa,0xab,0xc4,0x78,0x6c,0xab,0xbb,0xb5,0x7c,0x95,0xa4,0xb2,0x73,0x84,0xa0,0x88,0x96,0x72,0x8d,0xac,0x85,0xa7,0xad,0x82,0x9d,0xab,0x99,0x7c,0x72,0x6d,0x6b,0x8c,0x8a,0xa7,0x7d,0x68,0x86,0xaf,0xbb,0x79,0x83,0x8c,0x7b,0x72,0xb2,0x6f,0x77,0xb6,0xb8,0xf4,0xF6,0x8c,0x67,0xb6,0xb5"
for i in liste.split(","):
    print int(i,16)
```

Şeklinde kodumuzu yazdık ve dönüştürme işlemine geçtik okunabilir hale aşağıdaki gibi getirdik ve başladık içerisinde gözümüz ile aramaya

```
[154, 133, 158, 172, 170, 196, 164, 187, 190, 154, 100, 158, 142, 155, 112, 180, 129, 163, 129, 155, 156, 104, 104, 139
, 107, 131, 112, 129, 178, 185, 117, 167, 178, 152, 122, 144, 146, 192, 191, 100, 117, 104, 122, 197, 162, 170, 171, 19
6, 120, 108, 171, 187, 181, 124, 149, 164, 178, 115, 132, 160, 136, 150, 114, 141, 172, 133, 167, 173, 130, 157, 171, 1
53, 124, 114, 109, 107, 140, 138, 167, 125, 104, 134, 175, 187, 121, 131, 140, 123, 114, 178, 111, 119, 182, 184, 244,
246, 140, 103, 182, 181]
```

Baktığımızda bizden istediği şu olabilirdi.

```
(124,149,164,178)
```

veya

```
(111,119,182,184,244,246)
```

En uzun olanı seçiyoruz burada çünkü bize en uzun olanı soruyor. Oda ikinci bulduğumuz idi hemen md5 değerini alıyoruz.

```
ce549031ea58a4a7493dde46a2c71357
```

----------

**Soru 8**

*Splinter'ın bilgisayarından önemli veriler aldık, bunların ne olduğu bul ve bize bildir.* Bu soruda ise bize bir adet ne olduğu belirsiz bir dosya veriyor ancak dosyayı sistemimize indirip `file` ile baktığımızda bunun bir pcap dosyası olduğunu görüyoruz.

içerisinde ise host tarafına bağlanan bir USB belleğin paketleri bulunuyordu. "URB_INTERRUPT" ve cihaz bilgisi vs şimdi burada yapmamız gereken bir kaç işlem var öncelikli olarak bunlara karar verelim.

```
tshark -r splinter -T fields -e usb.capdata > dump.txt
```

devamı gelecek...

----------

**Soru 9**

*Şimdi de uygulamanın kullandığı veritabanı parolası lazım* Sorusuna geldik soruya geldiğimizde bizi ilk başta bi 404 hatası karşılıyordu. Çoğu kişi bu sayfanın gerçek olduğunu sanıp soru çalışmıyor diye twitterdan yazmaya başladı aslında olay `CTRL + U` bastığımızda sayfanın en altında gizlenmiş bir div içerisinde bulunan form ile gerçekleşiyordu F12 aracılığı ile tarayıcı tarafında `style` dosyasında bulunan değerleri kaldırdığınızda karşınıza 2 adet input ekranı geliyor haliyle buralar basittir diyip direk olarak `admin` yazdık ve içerdeydik veya jsfiddle gibi araçlar ile `admin` değeri ile post isteği attığınızda içeriye girebiliyorsunuz.

Her neyse karşımıza şu şekilde bir ekran geliyor ve aşağıda da ufak bir hata bulunuyordu ayrıca link yapısına baktığımızda bunun bir LFI olduğunu anlamak hiçte zor olmadı

![soru9siberyildiz](/assets/soru9siberyildiz.jpg)

Şimdi bu hata ışında biraz kurcalayalım. Bir kaç alt dizine inmemiz gerekiyor aslında çok değil hataya bakıldığında maximum 3 dizin aşağıya gitsek bu iş tamam bunun için ise biz şöyle bir payload seçtik

```
../db.php
```

linkimiz ise şu şekilde olacaktı

```
dd96a95ce40af42633d10802bd419bc5/sanayihirsizligi/index.php?file=..%2Fdb.php
```

urldecode ettiğinizde yukarıda vermiş olduğum payload olduğunu anlayabilirsiniz. Bu bilgiler ışığında oluşturduğumuz link ile girdiğimizde `flag` bir anda önümüze çıktı `FLAG: Om3rHal1sD3MIR` Bu değeride md5 formatına çevirdiğimizdede cevabımız tamamen hazırdı zaten

![soru9cevap](/assets/soru9cevap.jpg)

```
0ae4ce5c35afcc6f88501b24f8498c0f
```

----------

**Soru 10**

*Bu görev önünde iki seçenek var : başarılı olursun veya olamazsın* Bu soruda ilk olarak bi login kısmı geliyor burası basit zaten adam sana `admin olarak gir` diyor.

Kullanıcı adı: admin
Şifre: admin

Peki bundan sonra ne geliyor. Komutu çalıştıracak şifreyi bulmaya ve komutu çalıştırmaya komut zaten `ls` ancak komutu çalıştırmak için bizden bir adet şifre istiyor. Biraz uğraştıktan sonra elime geçen bir wordlist aracılığı ile get metodu kullanılan linke zorlama yaptık ve şifre karşımıza çıktı `adminlele`

```
9f0f364f34fc230630922d7c4ce66d68/cannotfindme/?pass[]=adminlele&cmd=ls
```

Giriş yaptıktan sonra ise içeride 3 adet dosya gözüküyor bize oda şöyle ki

```
index.php
readme.txt
try.html
```

Bunlar içerisinde `readme.txt` ve `try.html` gözümüze çarpıyor. kontrol ediyoruz. `try.html` dosyası içerisinde ise aşağıdaki satır yer alıyor.

```
read file /tmp/isThatFlag.txt
```

Tabi burada bazı arkadaşlar gidip dosyayı bulup okumak isteyeceklerdir. Ancak ana bizim girdiğimiz dosyanın adının `try` olduğunu göz önünde bulundurarak direk yukarıdaki değerin md5 halini aldık ve sonuç olumlu oldu

```
fc5b4590ba6b20619556c126d7aa101f
```

----------

**Soru 11**

*Holowy Conz den beklediğimiz mesaj geldi, acaba nedir ?*


----------


**Soru 12**

*Yapabileceğine inancımız tam.* Bu sorudada öncelikli olarak linki baya bi kurcaladık ne var ne yok diye bakma isteği duyduk sonra get isteği atmaya sql map ile denemeye başladık ilk olarak yüksek hızlı tarama işlemi yapınca site requestleri drop etmeye başladı bizde dedik bu böyle olmaz bir takım kısıtlamalar ile taramaya devam ettik şu şekilde bir URL elde ettik

```
index.php?id=1' UNION ALL SELECT NULL,CONCAT(0x716b626b71,0x756a64567375626642615a5042756b5551576d4345784d6e527a526545734a6c585a4a4745766175,0x71786b6271)-- mmYT--
```


----------


**Soru 13**

*Zararlı bir hacker'ın bilgisayarından veri elde ettik, içerisindeki hackerin şifresini bulabilir misin ?*


----------


**Soru 14**

*Nedir bu sence ?* Sorusunun ne olduğunu her ne kadar anlasak da cevaba ulaşamadık altın oran sorusu olup fibonacci ile rabbit seq arasında bir ilişki bulunmakta

### Yardımlarından dolayı

Yasin YAMAN<br>
Ömer İPEK<br>
Furkan KALKAN ve diğer tüm arkadaşlarıma teşekkürlerimi sunarım.
