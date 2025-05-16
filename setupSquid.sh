#!/bin/bash

echo "🔄 Updating the system (optional)"
# sudo dnf update -y

echo "📦 Installing Squid proxy server"
sudo dnf install -y squid

# Ensure Squid config directory exists
sudo mkdir -p /etc/squid

# Backup existing config
if [ -f /etc/squid/squid.conf ]; then
    echo "🗂️ Backing up existing squid.conf"
    sudo cp /etc/squid/squid.conf /etc/squid/squid.conf.bak
else
    echo "ℹ️ No existing squid.conf found"
fi

echo "📄 Creating whitelist and blacklist files"
# Add test entries
echo -e "neverssl.com\nexample.org" | sudo tee /etc/squid/whitelist.txt > /dev/null
echo -e ".facebook.com\n.youtube.com\nexample.com" | sudo tee /etc/squid/blacklist.txt > /dev/null

echo "⚙️ Writing new squid.conf"
sudo tee /etc/squid/squid.conf > /dev/null <<'EOL'
# Squid Proxy Configuration for HTTP and HTTPS Filtering

# Listen on default port
http_port 3128

# === ACL Definitions ===

# Domain lists
acl whitelist dstdomain "/etc/squid/whitelist.txt"          # For HTTP
acl whitelist_ssl ssl::server_name "/etc/squid/whitelist.txt"  # For HTTPS

acl blacklist dstdomain "/etc/squid/blacklist.txt"
acl blacklist_ssl ssl::server_name "/etc/squid/blacklist.txt"

# Basic rules
acl localhost src 127.0.0.1/32
acl SSL_ports port 443
acl Safe_ports port 80
acl Safe_ports port 443
acl CONNECT method CONNECT

# === Security Rules ===
http_access deny !Safe_ports
http_access deny CONNECT !SSL_ports

# === Access Control Rules ===

# Block HTTPS blacklisted domains
http_access deny blacklist_ssl

# Block HTTP blacklisted domains
http_access deny blacklist

# Allow HTTPS whitelisted domains
http_access allow whitelist_ssl

# Allow HTTP whitelisted domains
http_access allow whitelist

# Allow localhost machine
http_access allow localhost

# Deny everything else
http_access deny all
EOL

echo "🚀 Restarting Squid..."
sudo systemctl restart squid

echo "✅ Squid proxy setup complete!"
echo "📌 Set your browser to use proxy 127.0.0.1:3128"
echo "✍️ Add or remove domains from /etc/squid/whitelist.txt and blacklist.txt as needed"
