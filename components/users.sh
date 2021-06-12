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

Head "updating apt"
apt update  &>>$LOG
Stat $?

Head "installing java"
apt install openjdk-8-jre-headless -y  &>>$LOG
apt install openjdk-8-jdk-headless -y &>>$LOG
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
Stat $?

cd target/

java -jar users-api-0.0.1.jar
Stat $?

Head "pass the EndPoints in Service File"
sed -i -e "s/redis_host/redis.${DOMAIN}/" systemd.service
Stat $?

Head "Setup the systemd Service"
mv systemd.service /etc/systemd/system/users.service &>>$LOG
Stat $?
systemctl daemon-reload && systemctl start users && systemctl enable users &>>$LOG
Stat $?