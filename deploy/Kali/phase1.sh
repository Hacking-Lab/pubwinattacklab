#!/bin/bash

myhome="/opt/pubwinattacklab/deploy/Kali"
cd $myhome
source $myhome/setup.env
env > $myhome/allenv.env

# change local hosts file
sed -i "s/kali/${hostname}/" /etc/hosts

# Updating System
wget -q -O - https://archive.kali.org/archive-key.asc | apt-key add
export DEBIAN_FRONTEND=noninteractive
export DEBIAN_PRIORITY=critical

echo "`date`: starting system upgrade" >> /tmp/phase1.log
apt-get -qy update
echo "`date`: finished system upgrade" >> /tmp/phase1.log

echo "`date`: starting system upgrade" >> /tmp/phase1.log
#apt-get -qy -o "Dpkg::Options::=--force-confdef" -o "Dpkg::Options::=--force-confold" upgrade
#apt-get -qy -o "Dpkg::Options::=--force-confdef" upgrade
echo "`date`: finished system upgrade" >> /tmp/phase1.log

echo "`date`: starting autoclean" >> /tmp/phase1.log
apt-get -qy autoclean
echo "`date`: finished autoclean" >> /tmp/phase1.log

# Running Kali Tool Installation
echo "`date`: starting tool installation" >> /tmp/phase1.log
./phase2.sh
echo "`date`: finished tool installation" >> /tmp/phase1.log

