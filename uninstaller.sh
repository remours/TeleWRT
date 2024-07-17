#!/bin/bash

opkg update
clear
cd
service edy stop
rm -rf /root/TeleWRT
rm -rf /etc/init.d/edy
rm -rf /usr/bin/edy.py
sleep 5
clear
echo "PLEASE WAIT....."
sleep 10
echo "UNINSTALLING TOOLS....."
sleep 10
clear
echo "[+] UNINSTALLING TOOLS SUCCESSFULLY ✓"
echo "[+] THAKS FOR USING THIS TOOLS :)"
