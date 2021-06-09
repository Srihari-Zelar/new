#!/bin/bash

source components/common.sh

#Used export instead of service file
DOMAIN=ksrihari.online

OS_PREREQ

Head "Installing Nginx"
apt install nginx -y &>>$LOG
Stat $?

Head "Starting Nginx Service"
systemctl start nginx
systemctl enable nginx
Stat $?

Head "Installing NPM"
apt install npm -y &>>$LOG
Stat $?

Head "change and create the directories"
cd /var/www/html
rm -rf app
mkdir app &>>$LOG
cd app
Stat $?

DOWNLOAD_COMPONENT

cd frontend

Head "Installing NPM under the frontend path"
npm install --save-dev  --unsafe-perm node-sass &>>$LOG
Stat $?

Head "------------------------------"
sed -i 's|127.0.0.1:8080|login.$DOMAIN:8080|g' /var/www/html/app/frontend/config/index.js
sed -i 's|127.0.0.1:8080|todo.$DOMAIN:8080|g' /var/www/html/app/frontend/config/index.js
Stat $?

Head "Starting NPM"
systemctl restart nginx
npm start
Stat $?