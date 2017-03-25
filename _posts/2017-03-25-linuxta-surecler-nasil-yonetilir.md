---
layout: post
title: Linux'ta Süreçler Nasıl Yönetilir
date: 2017-03-25
type: post
categories: linux
description: Bir süreç, Linux işletim sistemi tarafından çalışan bir programı temsil etmektedir. Linux'ta ki her işlem, bir adres alanından ve sunucu
---

Bir süreç, Linux işletim sistemi tarafından çalışan bir programı temsil etmektedir. Linux'ta ki her işlem, bir adres alanından ve sunucu çekirdeğinde bir dizi veri yapısından oluşur. Adres alanı, işlemi, yürütülmekte olan kod ve kütüphaneleri, işlemin değişkenlerini ve işlem devam ederken çekirdek tarafından gerekli olan pek çok farklı ek bilgiyi içerir.

**PID** benzersiz bir kimlik numarasıdır ve çekirdek tarafından her işleme atanır. İşlemler oluşturulduğunda PIDler sırayla atanır.

**UID** oluşturan kişinin kullanıcı kimlik numarası

**EUID** işlemin belirli bir anda hangi kaynaklara ve dosyalara erişim izni olduğunu belirlemek için kullanılan 'etkili' kullanıcı kimliğidir.  Genel olarak, **UID** ve **EUID**, belirlenen programlar haricinde aynıdır.

**GID** işlemin grup kimlik numarasıdır. EGID, EUID'in UID ile ilişkili olduğu şekilde GID ile de ilgilidir. Kısacası, bir süreç aynı anda birçok grubun üyesi olabilir.

`ps` bu, süreçleri izlemek için kullanılan temel Linux sistem yöneticisi komutlarından biridir. Ps'nin farklı sürümleri dokümanlarda ve ekranlarında farklı olsa da, hepsi aynı bilgileri sağlar. Ps komut çıktısı süreçlerin PID, UID, öncelik ve kontrol terminalini gösterebilir. Ayrıca ne kadar CPU süresinin kullanıldığı, bir işlemin ne kadar bellek kullandığı ve halihazırdaki durumu hakkında bilgide verir.

İşlem durum kodları:

- **R**, çalışıyor - işlem yürütülüyor / yürütülüyor olabilir.
- **D**, kesintisiz uyku
- **S**, işlem bazında olayın tamamlanmasını bekliyor
- **T**, İzlenen veya durdurulan
- **Z**, Zombie - geçersiz işlem, sonlandırılmış bir işlem ancak yine de çekirdek işlem tablosunda dolaşıyor çünkü işlemin üst bölümü bu işlemin sonlandırma durumunu hala almamıştır.

Şimdi süreçleri görelim

```
ps aux
```

- **USER** İşlem sahibinin kullanıcı adı
- **PID** İşlem Kimliği
- **% CPU** Belirli bir işlemin kullandığı CPU yüzdesi
- **% MEM** Belirli bir işlemin kullandığı gerçek belleğin yüzdesi
- **VSZ** İşlemin sanal boyutu
- **RSS** Hafızadaki sayfa sayısı
- **TTY** Kontrol terminal kimliği
- **STAT** Geçerli işlem durumu
- **START** Komutun başladığı saat
- **TIME** Sürecin tükettiği CPU süresi

Çıktımız

```
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
systemd+   557  0.0  0.0 129340  4176 ?        Ssl  Mar24   0:00 /lib/systemd/systemd-timesyncd
root       603  0.0  0.0  46340  2852 ?        Ss   Mar24   0:00 /sbin/wpa_supplicant -s -B -P /run/wpa_supplicant.wlp3s0.pid -i wlp3s0 -D nl80211,wext -c /etc/wpa_supplicant/wpa_supplicant.conf -C /run/wpa_supplicant
root       618  0.0  0.0 180872  9964 ?        Ssl  Mar24   0:00 /usr/sbin/thermald --no-daemon --dbus-enable
clamav     620  0.0  0.1 154520 24864 ?        Ss   Mar24   0:00 /usr/bin/freshclam -d --foreground=true
root       621  0.0  0.0 250116  4120 ?        Ssl  Mar24   0:03 /usr/sbin/rsyslogd -n
rtkit      623  0.0  0.0 185744  3040 ?        SNsl Mar24   0:00 /usr/lib/rtkit/rtkit-daemon
root       624  0.0  0.0 422572  8844 ?        Ssl  Mar24   0:00 /usr/sbin/ModemManager
root       627  0.0  0.0  97176  7948 ?        Ss   Mar24   0:00 /usr/sbin/cupsd -l
message+   628  0.0  0.0  45828  4512 ?        Ss   Mar24   0:00 /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation
root       646  0.0  0.0  46896  5036 ?        Ss   Mar24   0:00 /lib/systemd/systemd-logind
root       647  0.0  0.0  35900  3368 ?        Ss   Mar24   0:00 /usr/sbin/irqbalance --foreground
avahi      649  0.0  0.0  47132  3648 ?        Ss   Mar24   0:00 avahi-daemon: running [0x2e88ce4.local]
root       658  0.0  0.0  29664  2848 ?        Ss   Mar24   0:00 /usr/sbin/cron -f
clamav     665  0.0  3.2 773184 531652 ?       Ssl  Mar24   0:06 /usr/sbin/clamd --foreground=true
avahi      675  0.0  0.0  47012   356 ?        S    Mar24   0:00 avahi-daemon: chroot helper
root       692  0.0  0.0 258596  9112 ?        Ssl  Mar24   0:00 /usr/sbin/cups-browsed
root       694  0.0  0.0 287952  8236 ?        Ssl  Mar24   0:00 /usr/lib/policykit-1/polkitd --no-debug
root       703  0.0  0.0  13260   180 ?        Ss   Mar24   0:00 /usr/sbin/mcelog --daemon
colord     720  0.0  0.0 314276 14048 ?        Ssl  Mar24   0:00 /usr/lib/colord/colord
postgres   729  0.0  0.1 287552 24780 ?        S    Mar24   0:00 /usr/lib/postgresql/9.6/bin/postgres -D /var/lib/postgresql/9.6/main -c config_file=/etc/postgresql/9.6/main/postgresql.conf
lp         731  0.0  0.0  83956  5524 ?        S    Mar24   0:00 /usr/lib/cups/notifier/dbus dbus://
postgres   738  0.0  0.0 287552  3868 ?        Ss   Mar24   0:00 postgres: 9.6/main: checkpointer process   
postgres   739  0.0  0.0 287552  3868 ?        Ss   Mar24   0:00 postgres: 9.6/main: writer process   
postgres   740  0.0  0.0 287552  3868 ?        Ss   Mar24   0:00 postgres: 9.6/main: wal writer process   
postgres   741  0.0  0.0 288136  6500 ?        Ss   Mar24   0:00 postgres: 9.6/main: autovacuum launcher process   
postgres   742  0.0  0.0 143336  4328 ?        Ss   Mar24   0:00 postgres: 9.6/main: stats collector process   
memcache   995  0.0  0.0 335692  2664 ?        Ssl  Mar24   0:01 /usr/bin/memcached -m 64 -p 11211 -u memcache -l 127.0.0.1
_dnscry+   996  0.0  0.0  33328  1780 ?        SLs  Mar24   0:00 /usr/sbin/dnscrypt-proxy /etc/dnscrypt-proxy/dnscrypt-proxy.conf
root       998  0.0  0.1  60696 22044 ?        Ss   Mar24   0:01 /usr/bin/python /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
root       999  0.0  0.0  69940  5600 ?        Ss   Mar24   0:00 /usr/sbin/sshd -D
root      1024  0.0  0.0  28424  2756 ?        Ss   Mar24   0:00 /usr/sbin/vsftpd /etc/vsftpd.conf
root      1030  0.0  0.0  14536  1808 tty1     Ss+  Mar24   0:00 /sbin/agetty --noclear tty1 linux
root      1034  0.0  0.0 289956  6372 ?        SLsl Mar24   0:00 /usr/sbin/lightdm
root      1039  0.0  0.0  14988   152 ?        Ss   Mar24   0:00 /usr/sbin/in.tftpd --listen --user tftp --address 0.0.0.0:69 --secure /srv/tftp
root      1040  0.0  0.0      0     0 ?        S<   Mar24   0:00 [iprt-VBoxWQueue]
root      1053  4.9  0.9 548492 149464 tty7    Ssl+ Mar24  10:58 /usr/lib/xorg/Xorg :0 -seat seat0 -auth /var/run/lightdm/root/:0 -nolisten tcp vt7 -novtswitch
root      1057  0.0  0.0      0     0 ?        S    Mar24   0:00 [iprt-VBoxTscThr]
unbound   1078  0.0  0.0  55532 11996 ?        Ss   Mar24   0:00 /usr/sbin/unbound -d
root      1093  0.0  0.0 159496  1648 ?        Ss   Mar24   0:00 nginx: master process /usr/sbin/nginx -g daemon on; master_process on;
www-data  1094  0.0  0.0 159852  3348 ?        S    Mar24   0:00 nginx: worker process
www-data  1095  0.0  0.0 159852  3348 ?        S    Mar24   0:00 nginx: worker process
www-data  1096  0.0  0.0 159852  3348 ?        S    Mar24   0:00 nginx: worker process
www-data  1097  0.0  0.0 159852  3348 ?        S    Mar24   0:00 nginx: worker process
www-data  1098  0.0  0.0 159852  3348 ?        S    Mar24   0:00 nginx: worker process
www-data  1099  0.0  0.0 159852  3348 ?        S    Mar24   0:00 nginx: worker process
www-data  1100  0.0  0.0 159852  3348 ?        S    Mar24   0:00 nginx: worker process
www-data  1101  0.0  0.0 159852  3348 ?        S    Mar24   0:00 nginx: worker process
lightdm   1158  0.0  0.0  65100  6556 ?        Ss   Mar24   0:00 /lib/systemd/systemd --user
lightdm   1159  0.0  0.0  85332  2300 ?        S    Mar24   0:00 (sd-pam)
lightdm   1170  0.0  0.0  44988  3388 ?        Ss   Mar24   0:00 /usr/bin/dbus-daemon --session --address=systemd: --nofork --nopidfile --systemd-activation
lightdm   1174  0.0  0.0 220204  6904 ?        Sl   Mar24   0:02 /usr/lib/at-spi2-core/at-spi2-registryd --use-gnome-session
lightdm   1178  0.0  0.0 284196  6232 ?        Ssl  Mar24   0:00 /usr/lib/gvfs/gvfsd
lightdm   1184  0.0  0.0 352160  5196 ?        Sl   Mar24   0:00 /usr/lib/gvfs/gvfsd-fuse /run/user/116/gvfs -f -o big_writes
root      1250  0.0  0.0  20468  1048 ?        Ss   Mar24   0:00 /sbin/dhclient -4 -v -pf /run/dhclient.wlp3s0.pid -lf /var/lib/dhcp/dhclient.wlp3s0.leases -I -df /var/lib/dhcp/dhclient6.wlp3s0.leases wlp3s0
root      1279  0.0  0.0 239516  6840 ?        Sl   Mar24   0:00 lightdm --session-child 14 23
mertcan   1285  0.0  0.0  65128  6588 ?        Ss   Mar24   0:00 /lib/systemd/systemd --user
mertcan   1286  0.0  0.0  85332  2300 ?        S    Mar24   0:00 (sd-pam)
mertcan   1294  0.0  0.0   4288  1468 ?        Ss   Mar24   0:00 /bin/sh /etc/xdg/xfce4/xinitrc -- /etc/X11/xinit/xserverrc
mertcan   1302  0.0  0.0  45896  4732 ?        Ss   Mar24   0:03 /usr/bin/dbus-daemon --session --address=systemd: --nofork --nopidfile --systemd-activation
mertcan   1330  0.0  0.0  11084   332 ?        Ss   Mar24   0:00 /usr/bin/ssh-agent x-session-manager
mertcan   1340  0.0  0.0 328608 15924 ?        Sl   Mar24   0:03 xfce4-session
mertcan   1344  0.0  0.0  56668  5012 ?        S    Mar24   0:00 /usr/lib/x86_64-linux-gnu/xfce4/xfconf/xfconfd
mertcan   1348  0.0  0.0  91604  3232 ?        SLs  Mar24   0:00 /usr/bin/gpg-agent --supervised
mertcan   1350  0.7  0.1 182440 22664 ?        S    Mar24   1:41 xfwm4 --display :0.0 --sm-client-id 265313172-944d-40be-a029-d9d6a2299553
mertcan   1352  0.2  0.1 265524 22212 ?        Sl   Mar24   0:32 xfce4-panel --display :0.0 --sm-client-id 2ed374871-a818-44e2-a69a-1e508062cafa
mertcan   1353  0.0  0.1 382952 19516 ?        Ssl  Mar24   0:01 xfsettingsd --display :0.0 --sm-client-id 26e1987b6-027f-4957-94a3-ba9ca2561612
mertcan   1355  0.0  0.2 583628 48808 ?        Sl   Mar24   0:10 xfdesktop --display :0.0 --sm-client-id 20cfcc1af-8f3f-4f15-81b6-90acc1eff138
root      1359  0.0  0.0 310360  8212 ?        Ssl  Mar24   0:00 /usr/lib/upower/upowerd
mertcan   1383  0.0  0.2 395348 33180 ?        Sl   Mar24   0:01 /usr/lib/x86_64-linux-gnu/xfce4/panel/wrapper-1.0 /usr/lib/x86_64-linux-gnu/xfce4/panel/plugins/libwhiskermenu.so 1 12582937 whiskermenu Whisker Menu Show a menu to easily access installed applications
mertcan   1385  0.0  0.0 170536 10412 ?        Ss   Mar24   0:00 xfce4-power-manager --restart --sm-client-id 2e5b6b6e6-1370-4614-9d01-42202e16a921
mertcan   1386  0.0  0.3 468892 64960 ?        Sl   Mar24   0:00 /opt/google/chrome/chrome --type=service
mertcan   1387  0.0  0.0   4288   760 ?        S    Mar24   0:00 /bin/sh ./bin//jetbrains-toolbox --minimize
mertcan   1388  0.0  0.0 166900 14064 ?        S    Mar24   0:00 /usr/lib/x86_64-linux-gnu/xfce4/panel/wrapper-1.0 /usr/lib/x86_64-linux-gnu/xfce4/panel/plugins/libsystray.so 12 12582938 systray Notification Area Area where notification icons appear
mertcan   1389  0.0  0.1 383368 29064 ?        Sl   Mar24   0:00 /usr/lib/x86_64-linux-gnu/xfce4/panel/wrapper-1.0 /usr/lib/x86_64-linux-gnu/xfce4/panel/plugins/libxfce4powermanager.so 8 12582939 power-manager-plugin Power Manager Plugin Display the battery levels of your devices and control the brightness of your display
mertcan   1390  0.0  0.2 698028 37564 ?        Sl   Mar24   0:01 /usr/lib/x86_64-linux-gnu/xfce4/panel/wrapper-2.0 /usr/lib/x86_64-linux-gnu/xfce4/panel/plugins/libpulseaudio-plugin.so 4 12582940 pulseaudio PulseAudio Plugin Adjust the audio volume of the PulseAudio sound system
mertcan   1391  0.0  0.0 284304  6336 ?        Ssl  Mar24   0:00 /usr/lib/gvfs/gvfsd
mertcan   1396  0.0  0.0 713168  5212 ?        Sl   Mar24   0:05 /usr/lib/gvfs/gvfsd-fuse /run/user/1000/gvfs -f -o big_writes
mertcan   1410  0.0  0.0 248376  2168 ?        Ssl  Mar24   0:00 /home/mertcan/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox --minimize
mertcan   1417  0.0  0.1 251916 31596 ?        Sl   Mar24   0:07 /usr/bin/python3 /usr/share/system-config-printer/applet.py
mertcan   1419  0.0  0.0 311880 13852 ?        Sl   Mar24   0:00 /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1
mertcan   1424  0.2  0.1 406592 27812 ?        Sl   Mar24   0:38 /usr/lib/x86_64-linux-gnu/xfce4/panel/wrapper-1.0 /usr/lib/x86_64-linux-gnu/xfce4/panel/plugins/libweather.so 5 12582942 weather Weather Update Show current weather conditions
mertcan   1425  0.0  0.1 400736 21428 ?        Sl   Mar24   0:00 light-locker
mertcan   1426  0.0  0.4 1239564 70952 ?       Sl   Mar24   0:02 share/jetbrains-toolbox/jetbrains-toolbox --disable-gpu --minimize
mertcan   1427  0.0  0.0 348672  5668 ?        Ssl  Mar24   0:00 /usr/lib/at-spi2-core/at-spi-bus-launcher
mertcan   1429  0.0  0.0 320616 14096 ?        Ssl  Mar24   0:00 xfce4-power-manager
mertcan   1434  0.0  0.0  45112  3836 ?        S    Mar24   0:00 /usr/bin/dbus-daemon --config-file=/usr/share/defaults/at-spi2/accessibility.conf --nofork --print-address 3
mertcan   1439  0.0  0.0 187292  4972 ?        Sl   Mar24   0:00 /usr/lib/dconf/dconf-service
mertcan   1443  0.0  0.0 220208  5416 ?        Sl   Mar24   0:03 /usr/lib/at-spi2-core/at-spi2-registryd --use-gnome-session
mertcan   1461  1.0  0.0 1420148 12996 ?       S<l  Mar24   2:19 /usr/bin/pulseaudio --start --log-target=syslog
mertcan   1466  0.0  0.0 355376 11000 ?        Ssl  Mar24   0:00 /usr/lib/gvfs/gvfs-udisks2-volume-monitor
root      1471  0.0  0.0 375596  7756 ?        Ssl  Mar24   0:01 /usr/lib/udisks2/udisksd --no-debug
mertcan   1484  0.0  0.0 269380  4772 ?        Ssl  Mar24   0:00 /usr/lib/gvfs/gvfs-goa-volume-monitor
mertcan   1492  0.0  0.0 281612  6416 ?        Ssl  Mar24   0:00 /usr/lib/gvfs/gvfs-gphoto2-volume-monitor
mertcan   1499  0.0  0.0 269296  5112 ?        Ssl  Mar24   0:00 /usr/lib/gvfs/gvfs-mtp-volume-monitor
mertcan   1504  0.0  0.0 370176  7428 ?        Ssl  Mar24   0:00 /usr/lib/gvfs/gvfs-afc-volume-monitor
mertcan   1514  0.0  0.0 360320  6768 ?        Sl   Mar24   0:00 /usr/lib/gvfs/gvfsd-trash --spawner :1.14 /org/gtk/gvfs/exec_spaw/0
mertcan   1519  0.0  0.0 195096  7076 ?        Ssl  Mar24   0:00 /usr/lib/gvfs/gvfsd-metadata
root      1706  0.0  0.0  20468  1916 ?        Ss   Mar24   0:00 /sbin/dhclient -4 -v -pf /run/dhclient.enp4s0.pid -lf /var/lib/dhcp/dhclient.enp4s0.leases -I -df /var/lib/dhcp/dhclient6.enp4s0.leases enp4s0
debian-+  1788  0.0  0.2  94000 46576 ?        Ss   Mar24   0:05 /usr/bin/tor --defaults-torrc /usr/share/tor/tor-service-defaults-torrc -f /etc/tor/torrc --RunAsDaemon 0
debian-+  1789  0.0  0.4 211128 67744 ?        Sl   Mar24   0:00 /usr/bin/python /usr/bin/obfsproxy managed
mertcan   1802  0.0  0.2 552572 48368 ?        Sl   Mar24   0:05 /usr/bin/Thunar --daemon
mertcan   1805  3.8  1.1 1897280 182712 ?      Sl   Mar24   8:32 /opt/Telegram/Telegram
mertcan   1825  7.1  1.6 1446616 268120 ?      Sl   Mar24  15:54 /opt/google/chrome/chrome
mertcan   1830  0.0  0.0   5980   720 ?        S    Mar24   0:00 cat
mertcan   1831  0.0  0.0   5980   760 ?        S    Mar24   0:00 cat
mertcan   1833  0.0  0.0   6344   768 ?        S    Mar24   0:00 /opt/google/chrome/chrome-sandbox /opt/google/chrome/chrome --type=zygote
mertcan   1834  0.0  0.2 387244 47708 ?        S    Mar24   0:00 /opt/google/chrome/chrome --type=zygote
mertcan   1836  0.0  0.0   6344   720 ?        S    Mar24   0:00 /opt/google/chrome/chrome-sandbox /opt/google/chrome/nacl_helper
mertcan   1837  0.0  0.0  37640  5320 ?        S    Mar24   0:00 /opt/google/chrome/nacl_helper
mertcan   1839  0.0  0.0 387244 12296 ?        S    Mar24   0:00 /opt/google/chrome/chrome --type=zygote
mertcan   1884  0.0  0.0 392204 12480 ?        S    Mar24   0:00 /opt/google/chrome/chrome --type=gpu-broker
mertcan   1890  0.0  0.0  70988  5580 ?        S    Mar24   0:00 /usr/lib/x86_64-linux-gnu/gconf/gconfd-2
mertcan   1920  0.3  1.2 1120484 211264 ?      Sl   Mar24   0:42 
root      5759  0.0  0.0      0     0 ?        S    Mar24   0:00 [kworker/3:0]
root      7547  0.0  0.0      0     0 ?        S    Mar24   0:00 [kworker/u16:0]
root      8190  0.0  0.0      0     0 ?        S    Mar24   0:00 [kworker/4:2]
root      8328  0.0  0.0      0     0 ?        S    Mar24   0:00 [kworker/0:2]
root      8851  0.0  0.0      0     0 ?        S    Mar24   0:00 [kworker/3:1]
root      9356  0.0  0.0      0     0 ?        S    Mar24   0:00 [kworker/6:0]
root      9394  0.0  0.0      0     0 ?        S    Mar24   0:00 [kworker/5:1]
root      9690  0.0  0.0  36312  4736 ?        Ss   Mar24   0:00 /usr/lib/bluetooth/bluetoothd
mertcan   9832  0.0  0.3 613172 62380 ?        Sl   Mar24   0:00 /usr/bin/python3 /usr/bin/blueman-applet
mertcan  10529  0.3  1.0 3613000 170784 ?      Sl   Mar24   0:16 /usr/share/spotify/spotify
mertcan  10531  0.0  0.2 389932 42308 ?        S    Mar24   0:00 /usr/share/spotify/spotify --type=zygote --no-sandbox --lang=en-US --log-file=/usr/share/spotify/debug.log --log-severity=disable --product-version=Spotify/1.0.49.125
mertcan  19957  0.0  0.0 143048 10032 ?        S    00:18   0:00 /usr/lib/x86_64-linux-gnu/xfce4/exo-1/exo-helper-1 --launch TerminalEmulator
mertcan  19958  3.6  0.2 579008 42080 ?        Sl   00:18   0:00 /usr/bin/xfce4-terminal
mertcan  19963  0.2  0.0  21228  5120 pts/0    Ss   00:18   0:00 bash
mertcan  19969  0.0  0.0  38300  3324 pts/0    R+   00:18   0:00 ps aux
```

Bir başka komutumuz `pstree`

```
systemd-+-ModemManager-+-{gdbus}
        |              `-{gmain}
        |-agetty
        |-at-spi2-registr-+-{gdbus}
        |                 `-{gmain}
        |-avahi-daemon---avahi-daemon
        |-bluetoothd
        |-clamd---{clamd}
        |-colord-+-{gdbus}
        |        `-{gmain}
        |-cron
        |-cups-browsed-+-{gdbus}
        |              `-{gmain}
        |-cupsd---dbus
        |-dbus-daemon
        |-2*[dhclient]
        |-dnscrypt-proxy
        |-freshclam
        |-in.tftpd
        |-irqbalance
        |-jetbrains-toolb---4*[{jetbrains-toolb}]
        |-lightdm-+-Xorg-+-{InputThread}
        |         |      |-{radeon_cs:0}
        |         |      |-{si_shader:0}
        |         |      |-{si_shader:1}
        |         |      |-{si_shader:2}
        |         |      `-{si_shader:3}
        |         |-lightdm-+-sh-+-ssh-agent
        |         |         |    `-xfce4-session-+-applet.py---{gmain}
        |         |         |                    |-chrome-+-{Chrome_CloudPri}
        |         |         |                    |        |-{Network File Th}
        |         |         |                    |        |-{NetworkChangeNo}
        |         |         |                    |        |-2*[{ServiceProcess_}]
        |         |         |                    |        |-{TaskSchedulerSe}
        |         |         |                    |        |-{WorkerPool/1987}
        |         |         |                    |        `-{inotify_reader}
        |         |         |                    |-jetbrains-toolb---jetbrains-toolb-+-{QDBusConnection}
        |         |         |                    |                                   |-{QXcbEventReader}
        |         |         |                    |                                   |-{Qt HTTP thread}
        |         |         |                    |                                   |-{Qt bearer threa}
        |         |         |                    |                                   `-{SemaphoreWaitin}
        |         |         |                    |-light-locker-+-{dconf worker}
        |         |         |                    |              |-{gdbus}
        |         |         |                    |              `-{gmain}
        |         |         |                    |-polkit-gnome-au-+-{gdbus}
        |         |         |                    |                 `-{gmain}
        |         |         |                    |-xfce4-panel-+-panel-1-whisker-+-{gdbus}
        |         |         |                    |             |                 `-{gmain}
        |         |         |                    |             |-panel-12-systra
        |         |         |                    |             |-panel-4-pulseau-+-{gdbus}
        |         |         |                    |             |                 `-{gmain}
        |         |         |                    |             |-panel-5-weather---{gmain}
        |         |         |                    |             |-panel-8-power-m-+-{gdbus}
        |         |         |                    |             |                 `-{gmain}
        |         |         |                    |             `-{gmain}
        |         |         |                    |-xfdesktop-+-{gdbus}
        |         |         |                    |           `-{gmain}
        |         |         |                    |-xfwm4
        |         |         |                    |-{gdbus}
        |         |         |                    `-{gmain}
        |         |         |-{gdbus}
        |         |         `-{gmain}
        |         |-{gdbus}
        |         `-{gmain}
        |-mcelog
        |-memcached---6*[{memcached}]
        |-nginx---8*[nginx]
        |-polkitd-+-{gdbus}
        |         `-{gmain}
        |-postgres---5*[postgres]
        |-pulseaudio-+-{alsa-sink-ALC28}
        |            `-{alsa-source-ALC}
        |-rsyslogd-+-{in:imklog}
        |          |-{in:imuxsock}
        |          `-{rs:main Q:Reg}
        |-rtkit-daemon---2*[{rtkit-daemon}]
        |-sshd
        |-supervisord
        |-systemd-+-(sd-pam)
        |         |-dbus-daemon
        |         |-gvfsd-+-{gdbus}
        |         |       `-{gmain}
        |         `-gvfsd-fuse-+-{gdbus}
        |                      |-{gmain}
        |                      |-{gvfs-fuse-sub}
        |                      `-2*[{gvfsd-fuse}]
        |-systemd-+-(sd-pam)
        |         |-Thunar-+-Telegram-+-3*[{MTP::internal::}]
        |         |        |          |-{QDBusConnection}
        |         |        |          |-3*[{QThread}]
        |         |        |          |-{QXcbEventReader}
        |         |        |          |-4*[{Qt HTTP thread}]
        |         |        |          |-{Qt bearer threa}
        |         |        |          |-{gdbus}
        |         |        |          `-{gmain}
        |         |        |-chrome-+-2*[cat]
        |         |        |        |-chrome-+-chrome
        |         |        |        |        |-{Chrome_ChildIOT}
        |         |        |        |        |-{TaskSchedulerSe}
        |         |        |        |        `-{Watchdog}
```

Bir başka komutumuz olan `top`

```
top - 00:25:14 up  3:49,  2 users,  load average: 0.17, 0.20, 0.22
Tasks: 268 total,   2 running, 266 sleeping,   0 stopped,   0 zombie
%Cpu(s):  1.8 us,  1.2 sy,  0.0 ni, 97.0 id,  0.1 wa,  0.0 hi,  0.0 si,  0.0 st
KiB Mem : 16345584 total, 10268056 free,  3218960 used,  2858568 buff/cache
KiB Swap: 16684028 total, 16684028 free,        0 used. 12399620 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                   
 1053 root      20   0  519932 141080 100416 R   4.6  0.9  11:12.81 Xorg                                                                                                                      
10529 mertcan   20   0 3613000 170784  87380 S   1.5  1.0   0:21.18 spotify                                                                                                                   
20362 mertcan   20   0  579504  41944  29576 S   1.5  0.3   0:00.16 xfce4-terminal                                                                                                            
 1355 mertcan   20   0  583628  49076  26092 S   1.0  0.3   0:11.32 xfdesktop                                                                                                                 
18006 mertcan   20   0 9872.8m 576236  32608 S   1.0  3.5   1:02.52 java                                                                                                                      
 1350 mertcan   20   0  182440  22664  16576 S   0.5  0.1   1:43.03 xfwm4                                                                                                                     
 1461 mertcan    9 -11 1420148  12996   9604 S   0.5  0.1   2:21.22 pulseaudio                                                                                                                
 1805 mertcan   20   0 1912712 198012  65136 S   0.5  1.2   8:32.42 Telegram                                                                                                                  
20374 mertcan   20   0   45044   3708   3004 R   0.5  0.0   0:00.01 top                                                                                                                       
    1 root      20   0  205176   7456   5272 S   0.0  0.0   0:01.46 systemd                                                                                                                   
    2 root      20   0       0      0      0 S   0.0  0.0   0:00.00 kthreadd                                                                                                                  
    3 root      20   0       0      0      0 S   0.0  0.0   0:00.04 ksoftirqd/0                                                                                                               
    4 root      20   0       0      0      0 S   0.0  0.0   0:00.26 kworker/0:0                                                                                                               
    5 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 kworker/0:0H                                                                                                              
    7 root      20   0       0      0      0 S   0.0  0.0   0:05.88 rcu_sched                                                                                                                 
    8 root      20   0       0      0      0 S   0.0  0.0   0:00.00 rcu_bh                                                                                                                    
    9 root      rt   0       0      0      0 S   0.0  0.0   0:00.00 migration/0                                                                                                               
   10 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 lru-add-drain                                                                                                             
   11 root      rt   0       0      0      0 S   0.0  0.0   0:00.01 watchdog/0                                                                                                                
   12 root      20   0       0      0      0 S   0.0  0.0   0:00.00 cpuhp/0                                                                                                                   
   13 root      20   0       0      0      0 S   0.0  0.0   0:00.00 cpuhp/1                                                                                                                   
   14 root      rt   0       0      0      0 S   0.0  0.0   0:00.01 watchdog/1                                                                                                                
   15 root      rt   0       0      0      0 S   0.0  0.0   0:00.08 migration/1                                                                                                               
   16 root      20   0       0      0      0 S   0.0  0.0   0:00.02 ksoftirqd/1                                                                                                               
   18 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 kworker/1:0H                                                                                                              
   19 root      20   0       0      0      0 S   0.0  0.0   0:00.00 cpuhp/2                                                                                                                   
   20 root      rt   0       0      0      0 S   0.0  0.0   0:00.01 watchdog/2                                                                                                                
   21 root      rt   0       0      0      0 S   0.0  0.0   0:00.08 migration/2                                                                                                               
   22 root      20   0       0      0      0 S   0.0  0.0   0:00.01 ksoftirqd/2                                                                                                               
   24 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 kworker/2:0H                                                                                                              
   25 root      20   0       0      0      0 S   0.0  0.0   0:00.00 cpuhp/3                                                                                                                   
   26 root      rt   0       0      0      0 S   0.0  0.0   0:00.01 watchdog/3                                                                                                                
   27 root      rt   0       0      0      0 S   0.0  0.0   0:00.08 migration/3                                                                                                               
   28 root      20   0       0      0      0 S   0.0  0.0   0:00.02 ksoftirqd/3                                                                                                               
   30 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 kworker/3:0H                                                                                                              
   31 root      20   0       0      0      0 S   0.0  0.0   0:00.00 cpuhp/4                                                                                                                   
   32 root      rt   0       0      0      0 S   0.0  0.0   0:00.01 watchdog/4                                                                                                                
   33 root      rt   0       0      0      0 S   0.0  0.0   0:00.08 migration/4                                                                                                               
   34 root      20   0       0      0      0 S   0.0  0.0   0:00.04 ksoftirqd/4                                                                                                               
   36 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 kworker/4:0H                                                                                                              
   37 root      20   0       0      0      0 S   0.0  0.0   0:00.00 cpuhp/5                                                                                                                   
   38 root      rt   0       0      0      0 S   0.0  0.0   0:00.01 watchdog/5                                                                                                                
   39 root      rt   0       0      0      0 S   0.0  0.0   0:00.08 migration/5                                                                                                               
   40 root      20   0       0      0      0 S   0.0  0.0   0:00.01 ksoftirqd/5                                                                                                               
   42 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 kworker/5:0H
```

`kill` - komut çoğu zaman bir işlemi sonlandırmak için kullanılır. Kill herhangi bir sinyal gönderebilir, ancak varsayılan olarak belirli bir SÜRE gönderir. Kill, normal kullanıcılar tarafından kendi süreçlerinde veya herhangi bir süreçte `root` kullanılarak kullanılabilir.

```
kill [-sinyal] pid
```

Burada sinyal, gönderilecek sinyalin numarası veya simgesel adıdır ve PID, hedef işlemin işlem tanımlama numarasıdır.

![killlinux](/assets/linuxkill.png)

Sinyal numarası olmayan bir kill TERM yakalanabilir, engellenebilir veya yok sayılabilir olduğundan dolayı işlemin öleceğini garanti edemeyiz yolda bu işleme bir şeyler olabilir. Bir tanıdık lazım bize

```
Kill -9 pid
```

yukarıdaki komut, 9 sinyali KILL'in yakalanamaması nedeniyle sürecin öleceğini garanti eder. Killall komutu süreçleri ada göre işletir ve öldürür. 

Peki bu `9` ne oluyor ?


- **SIGHUP (1)** Kontrol terminalinde veya denetleme sürecinin ölümünde bir hata tespit edildi. Yapılandırma dosyalarını yeniden yüklemek ve günlük dosyalarını açmak / kapatmak için SIGHUP kullan.
- **SIGKILL (9)** Sinyali öldür. İşlemi durdurmak için son çare olarak SIGKILL kullanın. Bu veri kayıt edilmez veya işlemi temizlemez.
- **SIGTERM (15)** Sonlandırma sinyali. Süreci öldürmek için varsayılan ve en güvenli yol budur.

Yukarıdaki açıklamalara göre `15` kullanmamız gerekiyor değil mi evet aslında öyle ancak kimi zaman kapanmayan uygulamalar olacaktır. işte bu yüzden `9` kullanıyoruz. çünkü artık kapatacaksanız zaten uygulamanın o anki yaptıklarını gözden çıkartmışsınız demektir zaten.

Misal, aşağıdaki komut tüm Telegram işlemlerini öldürür

```
sudo killall telegram
```

Şimdi her şeyi gördük sıra durdurma komutumuza `Ctrl + z` bu komut, geçerli ön plan sürecini duraklatmak ve arka plana taşımak için kullanılır.

```
# service nginx restart
Redirecting to /bin/systemctl restart  nginx.service
^Z
[1]+  Stopped                 service nginx restart
```

`jobs` arka planda çalışan mevcut işlerin bir listesini görüntüler

```
# jobs
[1]+  Stopped                 service nginx restart
```

`fg` Bu komut, bir arka plan işlemini ön plana taşımak için kullanılır

```
# fg 1
service nginx restart
```

Linux bir adet sunucunuz var ise veya evde *nix türevlerinden bazılarını kullanıyorsanız bu komutlardan bir veya birkaçını bilmek zorundasınız demektir.

öptüm bye <3