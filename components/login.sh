#!/bin/bash

source components/common.sh

#Used export instead of service file
DOMAIN=ksrihari.online

OS_PREREQ

Head " Adding User"
deluser app
useradd -m -s /bin/bash app &>>$LOG
Stat $?

Head " Changing directory to todo"
cd /home/app/
Stat $?

Head "Run the following command as a user with sudo privileges to download and extract the Go binary archive in the /usr/local directory:"
wget -c https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local &>>$LOG
Stat $?

Head "Adjusting the Path Variable"
export PATH=$PATH:/usr/local/go/bin
Stat $?

Head "Save the file, and load the new PATH environment variable into the current shell session:"
source ~/.profile
Stat $?

Head "Inside the workspace create a new directory /src"
mkdir -p ~/go/src &>>$LOG
cd  ~/go/src/
Stat $?

Head "Lets clone the code from github repository"
DOWNLOAD_COMPONENT
cd login/
apt update
Stat $?

Head "Navigate** to the ~/go/src/login/login directory and run go build to build the program:"
apt install go-dep &>>$LOG
go get &>>$LOG
go build &>>$LOG
Stat $?

Head "Now, lets set up the service with systemctl."
mv login.service /etc/systemd/system/login.service