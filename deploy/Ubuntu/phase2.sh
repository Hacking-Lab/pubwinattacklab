#!/bin/bash

myhome="/opt/pubwinattacklab/deploy/Ubuntu"
cd $myhome
source $myhome/setup.env
env > $myhome/allenv.env

echo "`date`: ================ START =================" >> $myhome/phase2.log
echo "`date`: phase2 script executed" >> $myhome/phase2.log

# change local hosts file
echo "`date`: change hosts file" >> $myhome/phase2.log
sed -i "s/ubuntu/${hostname}/" /etc/hosts


tooldir=/home/${admin_username}/tools
mkdir $tooldir
mkdir -p /opt/applic/

echo "`date`: ubuntu update" >> $myhome/phase2.log
apt-get update -yq

echo "`date`: ubuntu upgrade" >> $myhome/phase2.log
apt-get upgrade -yq

echo "`date`: install curl and more" >> $myhome/phase2.log
apt-get install curl apt-transport-https ca-certificates software-properties-common -y

echo "`date`: install docker" >> $myhome/phase2.log
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update -yq
apt-cache policy docker-ce
apt install docker-ce -yq

echo "`date`: install docker-compose" >> $myhome/phase2.log
curl -L "https://github.com/docker/compose/releases/download/1.28.6/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose -y
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
apt install python3-pip -y
pip3 install python-pip -y

echo "`date`: adding user to docker group" >> $myhome/phase2.log
usermod -aG docker ${admin_username}

echo "`date`: starting docker" >> $myhome/phase2.log
systemctl start docker

echo "`date`: enabling docker to start after reboot" >> $myhome/phase2.log
systemctl enable docker


# Running Ubuntu Tool Installation
echo "`date`: starting tool installation" >> $myhome/phase2.log
./phase3.sh
echo "`date`: finished tool installation" >> $myhome/phase2.log
echo "`date`: ============ SUCCESS ===============" >> $myhome/phase2.log


