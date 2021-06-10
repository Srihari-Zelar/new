#!/bin/bash

source components/common.sh

#Used export instead of service file
DOMAIN=ksrihari.online

OS_PREREQ

Head "Installing npm"
apt install npm -y &>>$LOG

Head "User adding"
useradd -m -s /bin/bash app &>>$LOG

cd /home/app/

DOWNLOAD_COMPONENT

cd todo/

Head "installing npm in todo"
npm install -y &>>$LOG
