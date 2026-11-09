#!/usr/bin/env bash
EV=$HOME/ubuntu-evidence
sudo mkdir -p /srv/grc-backups && sudo chmod 700 /srv/grc-backups
sudo tar -czpf /srv/grc-backups/public-before-test.tgz -C /var/www/grc-lab public
sha256sum /var/www/grc-lab/public/index.html | tee "$HOME/portal-before.sha256" "$EV/backup-hash.txt"
sudo ls -l /srv/grc-backups | tee "$EV/backup-listing.txt"
date -Is | tee "$EV/recovery-start.txt"
date +%s > "$EV/start.epoch"
sudo rm /var/www/grc-lab/public/index.html
echo "File deleted. Now run ./kali_tests.sh recovery-fail on Kali."
