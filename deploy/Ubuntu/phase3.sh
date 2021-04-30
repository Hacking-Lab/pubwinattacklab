#!/bin/bash

myhome="/opt/pubwinattacklab/deploy/Ubuntu"
cd $myhome
source $myhome/setup.env

echo "`date`: phase3 script executed" >> $myhome/phase3.log

echo "`date`: setup easyrsa, create CA and keys for traefik" >> $myhome/phase3.log
cd /opt/pubwinattacklab/deploy/easyrsa3
./setup.sh


echo "`date`: create directory /opt/applic" >> $myhome/phase3.log
mkdir -p /opt/applic/traefik
cd /opt/applic/traefik
wget https://github.com/traefik/traefik/releases/download/v1.7.30/traefik_linux-amd64
chmod +x ./traefik_linux-amd64



echo "`date`: tweak kernel for wazuh" >> $myhome/phase3.log
# Wazuh https://documentation.wazuh.com/current/docker/wazuh-container.html
sysctl -w vm.max_map_count=262144

echo "`date`: downloading wazuh" >> $myhome/phase3.log
cd /opt/applic/
git clone https://github.com/wazuh/wazuh-docker.git -b v4.1.2 --depth=1
cd ./wazuh-docker/
echo "`date`: starting wazuh" >> $myhome/phase3.log
docker-compose up -d


echo "`date`: phase3 script finished" >> $myhome/phase3.log

