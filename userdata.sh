#!/bin/bash
yum update -y
yum install httpd -y
systemctl restart httpd
systemctl enable httpd
yum install docker -y
systemctl start docker
docker run -itd -p 8080:80 nginx
docker run -itd -p 8081:80 nginx


cd /var/www/html
echo "<html><body><h1> Hello Terraform $(hostname -f) </h1></body></html>" > index.html
