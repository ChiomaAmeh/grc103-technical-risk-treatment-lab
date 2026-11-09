#!/usr/bin/env bash
EV=$HOME/ubuntu-evidence
sudo tail -n 30 /var/log/nginx/grc_access.log | tee "$EV/nginx-access-extract.txt"
sudo journalctl -k --since '30 minutes ago' | grep 'UFW BLOCK' | tail -n 20 | tee "$EV/ufw-block-log.txt"
sudo grep 'UFW BLOCK' /var/log/ufw.log 2>/dev/null | tail -n 20 | tee -a "$EV/ufw-block-log.txt"
