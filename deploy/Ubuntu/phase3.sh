#!/bin/bash

myhome="/opt/pubwinattacklab/deploy/Ubuntu"
cd $myhome
source $myhome/setup.env

echo "`date`: phase3 script executed" >> $myhome/phase3.log

# SETUP PKI
echo "`date`: setup easyrsa, create CA and keys for traefik" >> $myhome/phase3.log
cd $myhome/easyrsa3
./setup.sh

# Setup traefik
echo "`date`: create directory /opt/applic" >> $myhome/phase3.log
mkdir -p /opt/applic/traefik
cd /opt/applic/traefik
wget -q https://github.com/traefik/traefik/releases/download/v1.7.30/traefik_linux-amd64
chmod +x ./traefik_linux-amd64
cp $myhome/traefik/traefik.toml .


# Setup Docker
echo "`date`: tweak kernel for wazuh" >> $myhome/phase3.log
# Wazuh https://documentation.wazuh.com/current/docker/wazuh-container.html
sysctl -w vm.max_map_count=262144

# Setup Wazuh
echo "`date`: downloading wazuh" >> $myhome/phase3.log
cd /opt/applic/
git clone https://github.com/wazuh/wazuh-docker.git -b v4.1.2 --depth=1
cd ./wazuh-docker/
cp docker-compose.yml docker.compose.yml.ori
cp $myhome/wazuh/docker-compose.yml .
echo "`date`: starting wazuh" >> $myhome/phase3.log
docker-compose up -d

echo "`date`: phase3 script finished" >> $myhome/phase3.log

