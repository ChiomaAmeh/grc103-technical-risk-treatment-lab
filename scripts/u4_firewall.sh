#!/usr/bin/env bash
# usage: bash u4_firewall.sh KALI_IP   (run on the VM CONSOLE)
EV=$HOME/ubuntu-evidence
KALI_IP=${1:?usage: bash u4_firewall.sh KALI_IP}
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow from "$KALI_IP" to any port 80 proto tcp
sudo ufw logging on
sudo ufw --force enable
sudo ufw status numbered | tee "$EV/ufw-status-numbered.txt"
sudo ufw status verbose | tee "$EV/ufw-status-verbose.txt"
