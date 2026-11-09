#!/usr/bin/env bash
EV=$HOME/ubuntu-evidence
sudo mkdir -p /srv/grc-private
sudo mv /var/www/grc-lab/archive /srv/grc-private/
sudo chmod -R go-rwx /srv/grc-private
sudo tee /etc/nginx/sites-available/grc-lab >/dev/null <<'EOF'
server {
  listen 80;
  server_name _;
  root /var/www/grc-lab;
  access_log /var/log/nginx/grc_access.log combined;
  error_log /var/log/nginx/grc_error.log;
  location / { autoindex off; }
  location /archive/ { deny all; }
}
EOF
sudo nginx -t && sudo systemctl reload nginx
sudo cp /etc/nginx/sites-available/grc-lab "$EV/nginx-grc-lab-final.conf"
sudo ls -ld /srv/grc-private | tee "$EV/archive-permissions.txt"
