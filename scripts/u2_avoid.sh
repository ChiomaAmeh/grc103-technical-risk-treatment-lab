#!/usr/bin/env bash
EV=$HOME/ubuntu-evidence
date -Is | tee "$EV/avoidance-time.txt"
sudo systemctl disable --now grc-legacy
sudo systemctl is-active grc-legacy | tee "$EV/avoidance-is-active.txt"
sudo systemctl is-enabled grc-legacy | tee -a "$EV/avoidance-is-active.txt"
sudo ss -lntp | tee "$EV/avoidance-ss.txt"
