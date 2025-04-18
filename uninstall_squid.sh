#!/bin/bash

echo "Stop Squid Application"
sudo systemctl stop squid

echo "Removing the Application from the system."
sudo apt remove --purge -y squid

echo "Cleaning up the remaining files from system."
sudo rm -rf /etc/squid

echo "Squid Has been removed from the system."

#This script basically removes squid from the system.