#!/bin/sh
yum install httpd -y
echo '<h1> Resonse from Web-Server </h1>' >/var/www/html/index.html
chkconfig httpd on
service httpd start
