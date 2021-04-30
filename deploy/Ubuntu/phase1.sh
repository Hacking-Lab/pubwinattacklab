#!/bin/bash

myhome="/opt/pubwinattacklab/deploy/Ubuntu"
cd $myhome
source $myhome/setup.env
env > $myhome/allenv.env

echo "`date`: launching phase2.sh in the background - system upgrade" >> $myhome/phase1.log
screen -d -m -t phase2 ./phase2.sh &
sleep 3
echo "`date`: end of script phase1.sh" >> $myhome/phase1.log
echo "`date`: process list" >> $myhome/phase1.log
echo "`date`: =======================================" >> $myhome/phase1.log
ps -ef  >> $myhome/phase1.log
