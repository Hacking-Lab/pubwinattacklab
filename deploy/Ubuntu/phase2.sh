#!/bin/bash

myhome="/opt/pubwinattacklab/deploy/Ubuntu"
cd $myhome
source $myhome/setup.env
env > $myhome/allenv.env

echo "`date`: phase2 script executed" >> $myhome/phase2.log

# Updating System
export DEBIAN_FRONTEND=noninteractive
export DEBIAN_PRIORITY=critical

echo "`date`: starting system update" >> $myhome/phase2.log
apt-get -qy update
echo "`date`: finished system update" >> $myhome/phase2.log

echo "`date`: starting system upgrade" >> $myhome/phase2.log
apt-get -qy -o "Dpkg::Options::=--force-confdef" upgrade
echo "`date`: finished system upgrade" >> $myhome/phase2.log

echo "`date`: starting autoclean" >> $myhome/phase2.log
apt-get -qy autoclean
echo "`date`: finished autoclean" >> $myhome/phase2.log

echo "`date`: starting autoremove" >> $myhome/phase2.log
apt-get -qy autoremove
echo "`date`: finished autoremove" >> $myhome/phase2.log


# Running phase3 scripts Installation
echo "`date`: starting tool installation" >> $myhome/phase2.log
./phase3.sh
echo "`date`: finished tool installation" >> $myhome/phase2.log



