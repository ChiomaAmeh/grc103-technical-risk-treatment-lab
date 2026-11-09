#!/usr/bin/env bash
# Chioma Ameh | C11/26/CGRCE/17567 - BASELINE build on Ubuntu
EV=$HOME/ubuntu-evidence; mkdir -p "$EV"
ip -br addr | tee "$EV/ip-addr-ubuntu.txt"
sudo mkdir -p /var/www/grc-lab/public /var/www/grc-lab/archive /srv/grc-legacy
echo 'Approved internal portal' | sudo tee /var/www/grc-lab/public/index.html >/dev/null
echo 'DUMMY RECORD A001 - training only' | sudo tee /var/www/grc-lab/archive/dummy-records.txt >/dev/null
echo 'Legacy training endpoint' | sudo tee /srv/grc-legacy/index.html >/dev/null
sudo chmod -R a+rX /var/www/grc-lab /srv/grc-legacy
sudo tee /etc/systemd/system/grc-legacy.service >/dev/null <<'EOF'
[Unit]
Description=GRC lab legacy endpoint
[Service]
User=www-data
ExecStart=/usr/bin/python3 -m http.server 8080 --bind 0.0.0.0 --directory /srv/grc-legacy
[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo systemctl enable --now grc-legacy
sudo tee /etc/nginx/sites-available/grc-lab >/dev/null <<'EOF'
server {
  listen 80;
  server_name _;
  root /var/www/grc-lab;
  access_log /var/log/nginx/grc_access.log combined;
  error_log /var/log/nginx/grc_error.log;
  location / { autoindex on; }
}
EOF
sudo ln -sf /etc/nginx/sites-available/grc-lab /etc/nginx/sites-enabled/grc-lab
sudo rm -f /etc/nginx/sites-enabled/default
sudo nginx -t && sudo systemctl reload nginx
sudo cp /etc/nginx/sites-available/grc-lab "$EV/nginx-baseline.conf"
sudo ufw status verbose | tee "$EV/baseline-ufw.txt"
sudo ss -lntp | tee "$EV/baseline-ss.txt"
