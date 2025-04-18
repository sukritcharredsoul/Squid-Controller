#!/bin/bash

echo "Updating the system First !"
sudo apt update 

echo "Installing Squid : The caching and forward proxy."
sudo apt install -y squid


echo "Storing the original Squid.conf File for backups."

sudo cp /etc/squid/squid.conf /etc/squid/squid.conf.bak


echo "examples.com" | sudo tee /etc/squid/whitelist.txt 
echo "youtube.com" | sudo tee /etc/squid/blocked_sites.txt

echo "example.com" | sudo tee /etc/squid/blocked_sites.txt

sudo tee /etc/squid/squid.conf > /dev/null <<EOL

# Define allowed domains (whitelist)
acl whitelist dstdomain "/etc/squid/whitelist.txt"
http_access allow whitelist

# Deny access to all other domains by default
http_access deny all

# Define the proxy port
http_port 3128

# Block specific domains (blocked sites)
acl blocked dstdomain "/etc/squid/blocked_sites.txt"
http_access deny blocked


EOL

sudo systemctl restart squid

echo "Now the proxy setup is complete ! Configure your browser to use port 3128 to access the proxy."