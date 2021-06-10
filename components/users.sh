#!/bin/bash

source components/common.sh

OS_PREREQ

Head "User adding"
useradd -m -s /bin/bash todo &>>$LOG

cd /home/todo/

DOWNLOAD_COMPONENT

apt update  &>>$LOG

Head "installing java"
apt install openjdk-8-jre-headless  &>>$LOG

apt install openjdk-8-jdk-headless &>>$LOG

Head "exporting to java-home"
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 &>>$LOG

Head "installing maven"
apt install maven -y &>>$LOG

cd /home/todo/users/

Head "installing maven packages"
mvn clean package &>>$LOG

cd target/

java -jar users-api-0.0.1.jar