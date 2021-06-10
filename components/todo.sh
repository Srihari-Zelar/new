#!/bin/bash

source components/common.sh

#Used export instead of service file
DOMAIN=ksrihari.online

OS_PREREQ

Head "Installing npm"
apt install npm -y &>>$LOG
Stat $?

Head "User adding"
deluser app
useradd -m -s /bin/bash app &>>$LOG
cd /home/app/
Stat $?

rm -rf todo
DOWNLOAD_COMPONENT
Stat $?

cd todo/
Stat $?

Head "installing npm in todo"
npm install -y &>>$LOG
Stat $?
