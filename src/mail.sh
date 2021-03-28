sendmail -t <<EOT
TO: benoit.fauque@gmail.com
From: benoit.fauque.notif@gmail.com
SUBJECT: Courrier du $(date +"%d/%m/%y")
MIME-Version: 1.0
Content-Type: multipart/related;boundary="XYZ"
--XYZ
Content-Type: text/html; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=ISO-8859-15">
</head>
<body bgcolor="#ffffff" text="#000000">
<h1>T'as du courrier</h1>
<br>
Regarde comme il est beau :
<br>
<img src="cid:part1.06090408.01060107" alt="">

</body>
</html>
--XYZ
Content-Type: image/jpeg;name="c.jpg"
Content-Transfer-Encoding: base64
Content-ID: <part1.06090408.01060107>
Content-Disposition: inline; filename="c.jpg"
$(base64 c.jpg)
--XYZ--
EOT
