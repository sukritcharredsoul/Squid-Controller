#!/bin/bash

WHITELIST="/etc/squid/whitelist.txt"
BLACKLIST="/etc/squid/blocked_sites.txt"


domain=$(zenity --entry \
  --title="Add to Whitelist" \
  --text="Enter the domain you want to allow (e.g. example.com):")


domainB=$(zenity --entry \
  --title="Add to Blacklist" \
  --text="Enter the domain you want to block from Access:")


changed=false

if [[ -n "$domain" ]]; then
    echo "$domain" | sudo tee -a "$WHITELIST" > /dev/null
    changed=true
fi

if [[ -n "$domainB" ]]; then
    echo "$domainB" | sudo tee -a "$BLACKLIST" > /dev/null
    changed=true
fi

if [[ "$changed" = true ]]; then
    sudo systemctl restart squid
    zenity --info \
      --title="Success" \
      --text="Updated Squid configuration: Whitelist: $domain Blacklist: $domainB"
else
    zenity --warning --text="No domain entered!"
fi
