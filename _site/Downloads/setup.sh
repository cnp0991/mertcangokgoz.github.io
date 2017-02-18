#!/bin/bash
yum update -y

setenforce 0
service iptables stop
chkconfig iptables off
yum -y install nano wget
wget https://mertcangokgoz.com/Downloads/autodl-setup
sh autodl-setup
wget -O /etc/selinux/config https://mertcangokgoz.com/Downloads/config

rpm -Uvh http://mediaarea.net/download/binary/libzen0/0.4.29/libzen0-0.4.29-1.x86_64.CentOS_6.rpm
rpm -Uvh http://mediaarea.net/download/binary/libmediainfo0/0.7.63/libmediainfo0-0.7.63-1.x86_64.CentOS_6.rpm
rpm -Uvh http://mediaarea.net/download/binary/mediainfo/0.7.63/mediainfo-0.7.63-1.x86_64.CentOS_6.rpm
rpm -Uvh http://pkgs.repoforge.org/unrar/unrar-4.0.7-1.el6.rf.x86_64.rpm
rpm -Uhv http://packages.sw.be/rpmforge-release/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm
rpm -Uvh http://dl.atrpms.net/el6-x86_64/atrpms/stable/rar-3.9.3-4.el6.x86_64.rpm
git clone git://source.ffmpeg.org/ffmpeg.git

cd /tmp/

yum -y install SDL-devel a52dec a52dec-devel alsa-lib-devel faac faac-devel faad2 faad2-devel zip telnet git
yum -y install freetype-devel giflib gsm gsm-devel imlib2 imlib2-devel lame lame-devel libICE-devel libSM-devel libX11-devel
yum -y install libXau-devel libXdmcp-devel libXext-devel libXrandr-devel libXrender-devel libXt-devel
yum -y install id3tag-devel libogg libvorbis vorbis-tools mesa-libGL-devel mesa-libGLU-devel xorg-x11-proto-devel xvidcore xvidcore-devel zlib-devel
yum -y install amrnb-devel amrwb-devel libtheora theora-tools glibc gcc gcc-c++ autoconf automake libtool yasm nasm git-core opencore-amr-devel ncurses-devel
wget http://downloads.xiph.org/releases/ogg/libogg-1.3.0.tar.gz
tar xzvf libogg-1.3.0.tar.gz
cd libogg-1.3.0
./configure
make
make install

wget http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.3.tar.gz
tar xzvf libvorbis-1.3.3.tar.gz
cd libvorbis-1.3.3
./configure
make
make install

wget http://downloads.xiph.org/releases/theora/libtheora-1.1.1.tar.gz
tar xzvf libtheora-1.1.1.tar.gz
cd libtheora-1.1.1
./configure
make
make install

git clone http://git.chromium.org/webm/libvpx.git
cd libvpx
./configure --enable-shared --extra-cflags=-fPIC
make
make install

wget http://downloads.sourceforge.net/opencore-amr/vo-aacenc-0.1.2.tar.gz
tar xzvf vo-aacenc-0.1.2.tar.gz
cd vo-aacenc-0.1.2
./configure --enable-shared
make
make install

git clone git://git.videolan.org/x264.git
cd x264
./configure --enable-shared --extra-cflags=-fPIC --extra-asflags=-D__PIC__
make
make install


export LD_LIBRARY_PATH=/usr/local/lib/
echo /usr/local/lib > /etc/ld.so.conf.d/custom-libs.conf
ldconfig

wget http://www8.mplayerhq.hu/MPlayer/releases/codecs/all-20110131.tar.bz2
bunzip2 all-20110131.tar.bz2; tar xvf all-20110131.tar

mkdir /usr/local/lib/codecs/
mkdir /usr/local/lib64/codecs/
cp all-20110131/* /usr/local/lib/codecs/
cp all-20110131/* /usr/local/lib64/codecs/
chmod -R 755 /usr/local/lib/codecs/
chmod -R 755 /usr/local/lib64/codecs/




clear
echo 'Author Kadir Kalaycı Encoded Mertcan Gökgöz'
sleep 3
echo 'www.mertcangokgoz.com'
sleep 4
