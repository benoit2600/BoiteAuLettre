# BoiteAuLettre

Ce projet a pour but d'avoir une notification lorsque du courrier est mis dans ma boite au lettre. 
Pour cela, j'utilise une arduino nano, une raspberry pi zero w, et un montage a base de transistor MOSFET trouvé dans cette vidéo : [https://youtu.be/g1rbIG2BO0U](https://youtu.be/g1rbIG2BO0U).

## Principe

Lorsqu'un courrier est inserée dans la boite au lettre, un interrupteur fait un contact qui envoi un signal au transitor, qui active le courant jusqu'à la arduino et la Rpi. La Arduino a une Pin relié au second transistor (voir la vidéo) . Celle-ci est mise sur ON dès le démarrage de la arduino, ce qui permet de garder le mosfet PNP ON, et de garder l'alimentation active pour la Arduino et la RpI.

La Raspberry une fois allumé, envoie un signal sur une de ces PIN a la arduino, dans le but de lui dire "je suis allumé, et j'ai besoin de courant", puis fait une pause de 60s. Le but étant de laisser le temps au facteur de déposer le courrier, et fermer la boite au lettre. Ensuite, une led s'allume puis la photo est prise. 

Une fois prise, un script python la compare avec une photo de référence, dans le but de déterminer si il ya du courrier ou non. Et si un courrier est détecté, un mail m'est envoyé avec la photo du courrier. 

La detection est nécessaire, car lorsque je vais chercher le courrier, j'ouvre la porte destiné au colis, sur lequel un interrupteur est aussi placé. Il faut donc vérifier si il s'agit d'une "fausse alerte" ou non.


## Déroulement

La raspberry pi a dans son /home/pi/.profile une référence au fichier main.sh. 
Celui-ci active la Pin de vérification d'utilisation à destination de la arduino, fait la pause, puis allume la led et prend une photo à l'aide de l'utilitaire raspistill.

Puis le script compare.py compare la photo prise avec l'aide d'une photo de réference de la boite au lettre vide grace à l'aide de l'algorithme SSIM (script récuperer sur ce site : [Algo SSIM](https://www.pyimagesearch.com/2017/06/19/image-difference-with-opencv-and-python/ "Algo SSIM")) et de la librairie opencv.

Le chargement de la librairie et la comparaison prends environ 30s sur la pi zero avec une image de 640*480.

Si du courrier est detecté, un mail est envoyé. L'envoie de mail se fait en appelant le script mail.sh.

Puis, a des fin de debuggage, un fichier nommé boiteaulettredebug.txt est téléchargé. Ce fichier permet de determiner si la pi doit s'eteindre, ou si elle doit resté allumer pour débugger.

Lors de l'extinction, les pins sont remis a zero, la pin 27 est donc remise à zero, ce qui indique à la arduino qu'il est temps de s'eteindre.
