#!/bin/bash

# Function to enable SSH authentication via OpenLDAP
enableSSHAuthWithOpenLDAP() {
    sudo apt-get purge openssh-server
    sudo apt-get install -y openssh-server libpam-ldapd nscd
    sudo dpkg-reconfigure libpam-ldapd
}

# Function to restrict SSH access to users in the appropriate OpenLDAP group
restrictSSHAccess() {
    sudo sed -i '/^#UsePAM yes/c\UsePAM yes' /etc/ssh/sshd_config
    echo "AllowGroups teachers" | sudo tee -a /etc/ssh/sshd_config

    sudo systemctl restart ssh
}

# Function to test SSH access for an authorized and unauthorized user
testSSHAccess() {
    if [ -z "$1" ]; then
        read -p "Enter LDAP Username: " ldapUsername
    else
        ldapUsername="$1"
    fi

    ssh $ldapUsername@localhost
}
