#!/bin/bash

myhome="/opt/pubwinattacklab/deploy/Kali"
cd $myhome
source $myhome/setup.env

# Log everything to /home/${admin_username}/setup.log
file=/home/${admin_username}/setup.log
exec > $file
exec 2>&1

# Install tools
tooldir=/home/${admin_username}/tools
mkdir $tooldir

# Install Impacket
cd "$tooldir"
pip uninstall --quiet --yes impacket
rm --recursive impacket/
rm --recursive /usr/lib/python2.7/dist-packages/impacket/ 2> /dev/null
git clone --quiet https://github.com/CoreSecurity/impacket
cd impacket/
pip3 install --quiet .
cd /home/${admin_username}

# Install Kerbrute
kerbrute=$tooldir/kerbrute
wget https://github.com/ropnop/kerbrute/releases/download/v1.0.3/kerbrute_linux_amd64 -O $kerbrute
chmod +x $kerbrute

# Install ncat
apt-get -y install netcat ncat

# Download Mimikatz binaries
mimidir=$tooldir/mimikatz
wget https://github.com/gentilkiwi/mimikatz/releases/download/2.2.0-20200918-fix/mimikatz_trunk.zip -O /tmp/mimi.zip
unzip /tmp/mimi.zip -d $mimidir

# Download PowerSploit
powersploitdir=$tooldir/powersploit
mkdir $powersploitdir
git clone https://github.com/PowerShellMafia/PowerSploit.git $powersploitdir

# Install sysinternals suite
function dlSysInternals()
{
    url=$1
    type=$2
    wget $url -O /tmp/sysinternals/$type.zip
    mkdir $tooldir/sysinternals/$type
    unzip /tmp/sysinternals/$type.zip -d $tooldir/sysinternals/$type
}

mkdir $tooldir/sysinternals
mkdir /tmp/sysinternals
dlSysInternals https://download.sysinternals.com/files/SysinternalsSuite.zip default
dlSysInternals https://download.sysinternals.com/files/SysinternalsSuite-Nano.zip nano
dlSysInternals https://download.sysinternals.com/files/SysinternalsSuite-ARM64.zip arm

# Install pypykatz
apt-get install -y -o Dpkg::Options::=--force-confdef python3-pip
pip3 install pypykatz

# Install CrackMapExec
# 11.11.2020/KOV: added the force confdef parameter so that local config files are being kept
# setup used to stop here for user input otherwise
apt-get install -y -o Dpkg::Options::=--force-confdef gcc-8-base
apt-get install -y -o Dpkg::Options::=--force-confdef crackmapexec

# change owner of ${admin_username} folder to ${admin_username}
sudo chown ${admin_username}:${admin_username} -R /home/${admin_username}/

# upload logfile...
#logfile="/home/${admin_username}/setup.log"
#filename="${rg_lab_id}_kali1_setup.log"

#uploadurl="https://${storage_account_name}.blob.core.windows.net/${storage_container_name}/$filename${storage_account_sas}"
#curl -X PUT -d @"$logfile" -H "x-ms-blob-type: BlockBlob" "$uploadurl"

# test if file is uploaded
#curl -I "$uploadurl"


