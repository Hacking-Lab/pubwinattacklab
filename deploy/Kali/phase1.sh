#!/bin/bash

myhome="/opt/pubwinattacklab/deploy/Kali"
cd $myhome
source $myhome/setup.env
env > $myhome/allenv.env

# change local hosts file
sed -i "s/kali/${hostname}/" /etc/hosts

# Updating System
echo "`date`: starting system update" > /tmp/phase1.log
export DEBIAN_FRONTEND=noninteractive
export DEBIAN_PRIORITY=critical
wget -q -O - https://archive.kali.org/archive-key.asc | apt-key add
apt-get update -yq
echo "`date`: starting system upgrade" >> /tmp/phase1.log
apt-get upgrade -yq
echo "`date`: finished system upgrade" >> /tmp/phase1.log

# Running Kali Tool Installation
echo "`date`: starting tool installation" >> /tmp/phase1.log
./phase2.sh
echo "`date`: finished tool installation" >> /tmp/phase1.log

