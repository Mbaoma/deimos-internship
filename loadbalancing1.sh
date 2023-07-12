#!/bin/sh

# Install Dependencies
sudo apt update -y && sudo apt-get install -y git build-essential libpcre3 libpcre3-dev zlib1g zlib1g-dev libssl-dev libgd-dev libxml2 libxml2-dev uuid-dev

# Download Nginx Source Code
wget http://nginx.org/download/nginx-1.24.0.tar.gz
tar -zxvf nginx-1.24.0.tar.gz
cd nginx-1.24.0

# Build & Install Nginx
sudo ./configure \
    --prefix=/etc/nginx \
    --conf-path=/etc/nginx/nginx.conf \
    --error-log-path=/var/log/nginx/error.log \
    --http-log-path=/var/log/nginx/access.log \
    --pid-path=/run/nginx.pid \
    --sbin-path=/usr/sbin/nginx \
    --with-http_ssl_module \
    --with-http_v2_module \
    --with-http_stub_status_module \
    --with-http_realip_module \
    --with-file-aio \
    --with-threads \
    --with-stream \
    --with-stream_ssl_preread_module
sudo make && sudo make install

# Set NGINX systemd service file path
nginx_service_file="/lib/systemd/system/nginx.service"

# Create NGINX systemd service file
sudo tee $nginx_service_file > /dev/null <<EOT
[Unit]
Description=Nginx Custom From Source
After=syslog.target network-online.target remote-fs.target nss-lookup.target
Wants=network-online.target

[Service]
Type=forking
PIDFile=/run/nginx.pid
ExecStartPre=/usr/sbin/nginx -t
ExecStart=/usr/sbin/nginx
ExecReload=/usr/sbin/nginx -s reload
ExecStop=/bin/kill -s QUIT \$MAINPID
PrivateTmp=true

[Install]
WantedBy=multi-user.target
EOT

# Create NGINX Group
sudo groupadd nginx-group

# Create NGINX User
sudo useradd -r -g nginx-group -s /bin/false nginx

# Enable and Start Nginx service
sudo systemctl daemon-reload
sudo systemctl enable nginx
sudo systemctl start nginx

# Create /var/www/html directory
sudo mkdir -p /var/www/html
sudo mkdir -p /etc/nginx/sites-enabled
sudo mkdir -p /etc/nginx/sites-available

# Move the website folder into the `/var/www/html` folder
sudo mv website1 /var/www/html
cd /var/www/html/website1
sudo apt-get update
sudo apt-get install nodejs npm -y
npm install
npm install express
sudo ln -s /usr/bin/nodejs /usr/bin/node
nohup node main.js &

cd sites-available

CONFIG_FILE="/etc/nginx/sites-available/default"

# Create or edit the default configuration file
cat << EOF | sudo tee "$CONFIG_FILE" > /dev/null
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html/website2;
    index index.html index.htm;

    server_name _;

    location / {
        try_files $uri $uri/ =404;
        proxy_pass http://localhost:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
EOF

# Create a symbolic link to enable the configuration
sudo ln -s "$CONFIG_FILE" /etc/nginx/sites-enabled/default

#setup loadbalancing

# Define the load balancing configuration
load_balancing_config='
http {
    upstream backend {
        least_conn;
        server localhost:8000;
        server localhost:8080;
    }

    server {
        listen 80;

        location / {
            proxy_pass http://backend;
            proxy_set_header Host $host;
        }
    }
}
'

# Backup the original nginx.conf file
sudo cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak

# Append the load balancing configuration to nginx.conf
echo "$load_balancing_config" | sudo tee -a /etc/nginx/nginx.conf

#Cron Job
mkdir nginx_backup
# Specify the backup location
backup_location="/home/vagrant/nginx_backup"

# Create the backup directory if it doesn't exist
mkdir -p "$backup_location"

# Add the cron job to perform the backup
(crontab -l 2>/dev/null; echo "0 0 * * * sudo cp -R /var/www/html /etc/nginx /var/log  $backup_location") | crontab -

echo "Cron job for nginx backup has been successfully set up."

# Verify the Nginx configuration
sudo nginx -t
sudo systemctl daemon-reload
# Restart Nginx for the changes to take effect
sudo systemctl restart nginx

