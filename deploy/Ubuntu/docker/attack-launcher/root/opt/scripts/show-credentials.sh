#!/bin/bash
cd /winattacklab
echo "======= PUBLIC IP ADDRESSES ==================="
terraform output -no-color 2>&1 | tee -a /winattacklab/logs/terraform-ipaddresses.log
echo ""

echo "======= Win10 Client RDP Access ==============="
echo "Protocol: RDP with username/password authentication"
echo "Server: `terraform output winclient1_public_ip -no-color`"
echo "Domain: winattacklab.local"
echo "Username: tmassie"
echo "Password: WinLAB!123"
echo ""

echo "======= Kali VM SSH Access ===================="
echo "Protocol: SSH with publickey authentication"
echo "Server:   `terraform output kali1_public_ip -no-color`"
cat /tmp/credentials.txt
echo ""
echo "Password: see ssh private key below"
echo "Command:  ssh -i ~/.ssh/kali_private_key lab_admin@`terraform output kali1_public_ip -no-color`"
echo ""
echo "======= Kali VM SSH PRIVATE KEY ==============="
echo ""
cat /winattacklab/modules/kali1-client/kali_private_key
echo ""

echo "======= Kali VM SSH COMMAND ==================="
echo "Please copy ssh private key from above to ~/.ssh/kali_private_key"
echo "Please set permissions to 600 for  ~/.ssh/kali_private_key"
echo "Please use the following ssh command:  ssh -i ~/.ssh/kali_private_key lab_admin@`terraform output kali1_public_ip -no-color`"


