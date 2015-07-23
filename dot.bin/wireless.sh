#!/bin/sh

iwconfig eth2 2>&1 | grep -q no\ wireless\ extensions\. && {
  echo wired
  exit 0
}

essid=`iwconfig wlp3s0 | grep ESSID | cut -d':' -f2`
stngth=`iwconfig wlp3s0 | grep 'Link Quality' |cut -d'=' -f2|cut -d'/' -f1`
bars=`expr $stngth / 7`

case $bars in
  0)  bar='[----------]' ;;
  1)  bar='[/---------]' ;;
  2)  bar='[//--------]' ;;
  3)  bar='[///-------]' ;;
  4)  bar='[////------]' ;;
  5)  bar='[/////-----]' ;;
  6)  bar='[//////----]' ;;
  7)  bar='[///////---]' ;;
  8)  bar='[////////--]' ;;
  9)  bar='[/////////-]' ;;
  10) bar='[//////////]' ;;
  *)  bar='[----!!----]' ;;
esac

vpn_active=`ip route show |grep tun |head -n1`

if [ "$vpn_active" = "" ]; then
  echo $essid $bar
else
  echo $essid $bar [IPredator]
fi

exit 0
