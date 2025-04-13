# ProxyServerWithSquid
We are configuring a proxy server via Squid.

# Squid Proxy Server Automation

This project sets up a basic HTTP proxy server using Squid on Debian-based Linux systems.  
It automates installation, configuration, and service management using a Bash script.
You must use a debian Based System to run the scripts preferably Ubuntu LTS Version.


# After Installation Stuff 
This is a proxy server so basically it acts as a mediator , now the browser should know if there's a proxy involed hence to acess the files you do need to configure the browser as well.
Port 3128 is the default squid port.


## Features
- Automated Squid installation
- Custom access control rules
- Easy uninstall script

## How to Run
```bash
chmod +x setup_squid.sh
sudo ./setup_squid.sh
