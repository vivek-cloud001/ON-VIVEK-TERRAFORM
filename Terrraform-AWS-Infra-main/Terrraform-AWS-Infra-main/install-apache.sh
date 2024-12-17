#!/bin/bash
yum update -y 
yum install -y httpd
systemctl start httpd
systemctl enable https
echo "Web tier Access" > /var/www/html/index.html