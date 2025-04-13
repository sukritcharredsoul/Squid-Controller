#!/bin/bash

echo "Updating the system First !"
sudo apt update 

echo "Installing Squid : The caching and forward proxy."
sudo apt install -y squid


echo "Storing the original Squid.conf File for backups."
sudo cp /etc/squid/squid.conf /etc/squid/squid.conf.bak


echo "example.com" | sudo tee /etc/squid/whitelist.txt 

sudo tee /etc/squid/squid.conf > /dev/null <<EOL
acl whitelist dstdomain "/etc/squid/whitelist.txt"
http_access allow whitelist
http_access deny all
http_port 3128
EOL

sudo systemctl restart squid

echo "Now the proxy setup is complete ! Configure your browser to use port 3128 to access the proxy."