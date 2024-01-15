# DNS Server Configuration for Network Services
### This repository contains scripts and configuration files for setting up a DNS (Bind) server on a separate machine and configuring it to resolve domain names for OpenLDAP, Apache, and OpenVPN services.

# Section 1: Configuration of DNS Server
 ### 1.1 Install Bind9
 To install Bind9, run the following commands:
    
    sudo apt update
    sudo apt install bind9 -y
 ### 1.2 Create DNS Zone Files
  Modify the IP addresses in the gl4.tn.zone file to match your network configuration.
  Optionally, modify the IP address in the db.99.56.168.192 file for reverse DNS lookup. 
  
    sudo cp "$(dirname "$0")/gl4.tn.zone" /etc/bind/gl4.tn.zone
 ### Optional: Set up reverse zone file 
    sudo cp "$(dirname "$0")/db.99.56.168.192" /etc/bind/db.99.56.168.192
 ### 1.3 Update Main Configuration Files
 Copy the provided named.conf.local and named.conf.options files to the Bind configuration directory:

    sudo cp "$(dirname "$0")/named.conf.local" /etc/bind/named.conf.local
    sudo cp "$(dirname "$0")/named.conf.options" /etc/bind/named.conf.options
 ### 1.4 Check Configuration Files
Ensure the correctness of the configuration files:

    sudo named-checkconf /etc/bind/named.conf.local
    sudo named-checkconf /etc/bind/named.conf
 ### 1.5 Verify DNS Zone File
Verify the syntax of the DNS zone file:

    sudo named-checkzone gl4.net /etc/bind/gl4.tn.zone

 ### 1.6 Restart Bind9
 Restart the Bind9 service to apply the changes:

    sudo systemctl restart bind9



 ### 1.7 Verify Resolution
    dig gl4.tn
