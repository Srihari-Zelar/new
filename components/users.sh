#!/bin/bash

source components/common.sh

OS_PREREQ

Head "User adding"
deluser app
useradd -m -s /bin/bash app &>>$LOG

cd /home/app/
Stat $?

Head "Downloading component"
rm -rf users
DOWNLOAD_COMPONENT
Stat $?

apt update  &>>$LOG
Stat $?

Head "installing java"
apt-get install openjdk-8-jre-headless  &>>$LOG
Stat $?
apt-get install openjdk-8-jdk-headless &>>$LOG
Stat $?

Head "exporting to java-home"
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 &>>$LOG
Stat $?

Head "installing maven"
apt install maven -y &>>$LOG
cd users/
Stat $?

Head "installing maven packages"
mvn clean package &>>$LOG
cd target/
java -jar users-api-0.0.1.jar
Stat $?