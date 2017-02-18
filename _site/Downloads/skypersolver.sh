#!/usr/bin/env bash 
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
COL_BLUE=$ESC_SEQ"34;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_CYAN=$ESC_SEQ"36;01m"


echo -e "$COL_RED Lutfen Kullanici Adini Giriniz $COL_RESET"
read username
echo -e "$COL_BLUE Lutfen Bekleyin. I.P Cozumleniyor. $COL_RESET"
touch temp3
echo "skype=$username&resolveSkype=" >temp3
curl --silent -i -s -k  -X 'POST'     -H 'User-Agent: Mozilla/5.0 (X11; Linux i686; rv:32.0) Gecko/20100101 Firefox/32.0' -H 'Referer: http://skresolver.com/' -H 'Content-Type: application/x-www-form-urlencoded' --data-binary @temp3     'http://skresolver.com/' > out
rm temp3
if [[ -n $(cat out | grep Error) ]]; then
    echo "Hata: Daha Sonra tekrar deneyin."
    rm out
else

ip=$(grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' out)
rm out
echo -e "$username I.P Adresi: $ip "
fi