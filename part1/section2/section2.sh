#!/bin/bash

# Section 2: Authentication SSH

# Function to enable SSH authentication via OpenLDAP
enableSSHAuthWithOpenLDAP() {
    sudo apt-get purge openssh-server
    # Ensure OpenLDAP and SSH are installed
    sudo apt-get install -y openssh-server libpam-ldapd nscd

    # Configure libpam-ldapd for SSH authentication
    sudo dpkg-reconfigure libpam-ldapd
}

# Function to restrict SSH access to users in the appropriate OpenLDAP group
restrictSSHAccess() {
    # Configure SSH to use PAM
    sudo sed -i '/^#UsePAM yes/c\UsePAM yes' /etc/ssh/sshd_config

    # Restrict SSH access to users in the specified OpenLDAP group
    echo "AllowGroups teachers" | sudo tee -a /etc/ssh/sshd_config

    # Restart SSH service
    sudo systemctl restart ssh
}

# Function to test SSH access for an authorized and unauthorized user
testSSHAccess() {
    if [ -z "$1" ]; then
            read -p "Enter LDAP Username: " ldapUsername
        else
            ldapUsername="$1"
    fi    # Test SSH access for a user
    ssh $ldapUsername@localhost

}
