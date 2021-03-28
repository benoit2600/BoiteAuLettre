#!/bin/bash

cd /home/pi

POWER=0
gpio -g write 27 1
gpio -g mode 27 out
gpio -g write 27 1

echo "debut main.sh"

gpio -g mode 23 out
echo "pause 60s"

sleep 60
gpio -g write 23 1

echo "petite photo au calme"

raspistill -w 640 -h 480 -o c.jpg  
if [ $? -ne 0 ]
then
	logger -n 192.168.0.19 -t boiteaulettre -p user.error --rfc3164 "Erreur module caméra"
fi
gpio -g write 23 0

echo "on compare"

python3 ./compare.py -f /home/pi/ref.jpg -s /home/pi/c.jpg

if [ $? -eq 0 ]
then
	echo "Ya du courrieEeEeEer"

	logger -n 192.168.0.19 -t boiteaulettre -p user.notice --rfc3164 "Ya du courrieEeEeEer"

	./mail.sh
	echo "Mail envoyé"
else
	echo "Y a rien frère"

	logger -n 192.168.0.19 -t boiteaulettre -p user.notice --rfc3164 "Ya rien frère :-("
fi

sync
sleep 1


echo "ca debug ou pas ?"


mv /home/pi/c.jpg /home/pi/c-old.jpg
wget http://192.168.0.19:12084/boiteaulettredebug.txt > /dev/null

if [ -f "/home/pi/boiteaulettredebug.txt" ]; then
    POWER=`cat boiteaulettredebug.txt`
fi

rm -f boiteaulettredebug.txt


if [ $POWER -eq 0 ]; then
	echo "c'est fini"
	sudo poweroff
	exit
fi

echo "debuggage activé"




