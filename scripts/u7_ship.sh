#!/usr/bin/env bash
# usage: bash u7_ship.sh KALI_USER KALI_IP   (run: sudo systemctl start ssh on Kali first)
scp "$HOME"/ubuntu-evidence/* "$1@$2:~/grc103-technical-risk-treatment-lab/evidence/ubuntu/"
