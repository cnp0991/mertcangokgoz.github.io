#!/bin/sh

echo "$(tput setaf 3)--- Kernel 4 Kurulacak `uname -i` system---$(tput sgr0)"

echo ""

sleep 2

read -p "Devam Etmek icin ENTER tusuna basiniz,Vazgecmek icin ise CTRL+C basiniz" nothing

echo ""
echo ""

#i386 links

link1="http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.0-vivid/linux-headers-4.0.0-040000_4.0.0-040000.201504121935_all.deb"

link2="http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.0-vivid/linux-headers-4.0.0-040000-generic_4.0.0-040000.201504121935_i386.deb"

link3="http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.0-vivid/linux-image-4.0.0-040000-generic_4.0.0-040000.201504121935_i386.deb"

#amd64 links

url1="http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.0-vivid/linux-headers-4.0.0-040000-generic_4.0.0-040000.201504121935_amd64.deb"

url2="http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.0-vivid/linux-image-4.0.0-040000-lowlatency_4.0.0-040000.201504121935_amd64.deb"

#System architecture

arch=`uname -m`
if  [ $arch = i686 ] || [ $arch = i386 ]; then

mkdir -p $HOME/kernel-i386

cd $HOME/kernel-i386

wget -c $link1
wget -c $link2
wget -c $link3

sudo dpkg -i *.deb

sudo rm -rf $HOME/kernel-i386

elif [ $arch = "x86_64" ]; then

mkdir -p $HOME/kernel-amd64

cd $HOME/kernel-amd64

wget -c $link1
wget -c $url1
wget -c $url2

sudo dpkg -i *.deb

sudo rm -rf $HOME/kernel-amd64

     else
        echo "Desteklenmeyen Mimari"
fi
