#!/bin/bash

WHITELIST="/etc/squid/whitelist.txt"

# Ask for a domain to add
domain=$(zenity --entry \
  --title="Add to Whitelist" \
  --text="Enter the domain you want to allow (e.g. example.com):")

if [[ -n "$domain" ]]; then
    echo "$domain" | sudo tee -a "$WHITELIST" > /dev/null
    sudo systemctl restart squid
    zenity --info \
      --title="Success" \
      --text="$domain has been added to whitelist and Squid was restarted."
else
    zenity --warning --text="No domain entered!"
fi
