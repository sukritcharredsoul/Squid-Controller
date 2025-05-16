#!/bin/bash

echo "Update the system"
# sudo dnf update -y

echo "Install Squid proxy server"
sudo dnf install -y squid


sudo mkdir -p /etc/squid

if [ -f /etc/squid/squid.conf ]; then
    echo "Back up existing squid.conf"
    sudo cp /etc/squid/squid.conf /etc/squid/squid.conf.bak
else
    echo "No existing squid.conf found"
fi

echo "Creating whitelist and blacklist files"

echo "Alter the squid.conf"
sudo tee /etc/squid/squid.conf > /dev/null <<'EOL'



http_port 3128

acl whitelist dstdomain "/etc/squid/whitelist.txt"          
acl whitelist_ssl ssl::server_name "/etc/squid/whitelist.txt"  

acl blacklist dstdomain "/etc/squid/blacklist.txt"
acl blacklist_ssl ssl::server_name "/etc/squid/blacklist.txt"


acl localhost src 127.0.0.1/32
acl SSL_ports port 443
acl Safe_ports port 80
acl Safe_ports port 443
acl CONNECT method CONNECT


http_access deny !Safe_ports
http_access deny CONNECT !SSL_ports



http_access deny blacklist_ssl
http_access deny blacklist

http_access allow whitelist_ssl
http_access allow whitelist

http_access allow localhost

http_access deny all
EOL

echo "Restart Squid"
sudo systemctl restart squid

echo "✅ Squid proxy setup complete!"
echo "📌 Set your browser to use proxy 127.0.0.1:3128"
echo "✍️ Add or remove domains from /etc/squid/whitelist.txt and blacklist.txt as needed"
