#!/bin/bash

myhome="/opt/pubwinattacklab/deploy/Kali"
cd $myhome
source $myhome/setup.env
env > $myhome/allenv.env

# Testing for ENV variables
echo "${admin_username}" >> $myhome/phase1.env
echo "${hostname}" >> $myhome/phase1.env
echo "${storage_account_name}" >> $myhome/phase1.env
echo "${storage_container_name}" >> $myhome/phase1.env
echo "${storage_account_sas}" >> $myhome/phase1.env
echo "${rg_lab_id}" >> $myhome/phase1.env


