rem This file created by AIST ROUTE 1.1.0.0
rem Date of creation : 10:30:26 / 13.08.2008
set MyRouter=192.168.0.13
route -f print
ipconfig /renew
route -p add 10.0.0.0 mask 255.0.0.0 %MyRouter%
rem Ethernet дл€ дома
route -p add 172.16.0.0 mask 255.240.0.0 %MyRouter%
rem Ёлит 2.0
route -p add 192.168.0.0 mask 255.255.255.0 %MyRouter%
rem Wi-Fi
route -p add 195.144.200.10 %MyRouter%
rem radio.avtograd.ru
route -p add 81.28.160.111 %MyRouter%
rem irc.avtograd.ru
route -p add 81.28.160.25 %MyRouter%
rem aist2.mytlt.ru
route print
rem Thank you for using this software :)
pause
