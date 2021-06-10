#!/bin/bash

source components/common.sh
DOMAIN=ksrihari.online

OS_PREREQ

Head "Installing Golang"
apt install golang -y &>>$LOG
apt install unzip -y &>>$LOG
Stat $?

Head "Downloading Component"
DOWNLOAD_COMPONENT
Stat $?

Head "Extract Downloaded Archive"
cd /home/ubuntu
rm -rf login
unzip -o /tmp/login.zip &>>$LOG
mv login-main login
cd /home/ubuntu/login
export GOPATH=/home/ubuntu/go
export GOBIN=$GOPATH/bin
go get
go build
Stat $?

Head "Update EndPoints in Service File"
sed -i -e "s/user_endpoint/users.${DOMAIN}/" /home/ubuntu/login/systemd.service
Stat $?