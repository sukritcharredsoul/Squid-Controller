#!/bin/bash

echo "Updating the system First !"
sudo apt update 

echo "Installing Squid : The caching and forward proxy."
sudo apt install -y squid


echo "Storing the original Squid.conf File for backups."
sudo cp /etc/squid/squid.conf /etc/squid/squid.conf.bak


sudo bash -c 'cat > /etc/squid/squid.conf << EOF
http_port 3128
acl allowed_sites dstdomain .google.com
http_access allow allowed_sites
http_access deny all
EOF'


sudo systemctl restart squid

echo "Now the proxy setup is complete ! Configure your browser to use port 3128 to access the proxy."