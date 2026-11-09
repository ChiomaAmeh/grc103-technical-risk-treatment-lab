#!/usr/bin/env bash
EV=$HOME/ubuntu-evidence
sudo tar -xzpf /srv/grc-backups/public-before-test.tgz -C /var/www/grc-lab
sha256sum -c "$HOME/portal-before.sha256" | tee "$EV/recovery-hash-check.txt"
date -Is | tee "$EV/recovery-end.txt"
END=$(date +%s); START=$(cat "$EV/start.epoch")
echo "Recovery time: $((END-START)) seconds" | tee "$EV/recovery-time.txt"
