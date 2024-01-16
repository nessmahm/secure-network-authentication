#!/bin/bash

# Function to install OpenVPN
installOpenVpn() {
    sudo apt-get update
    sudo apt-get install openvpn
    sudo apt-get install libpam-ldap
    sudo apt-get install openvpn-auth-ldap
}

# Function to configure OpenVPN server
configureOpenVpn() {
    sudo openssl dhparam -out /etc/openvpn/dh2048.pem 2048

    sudo openssl genpkey -algorithm RSA -out "/etc/openvpn.key"
    sudo openssl req -new -key "/etc/openvpn.key" -out "/etc/openvpn.csr" -subj "/CN=openvpn"
    sudo openssl x509 -outform PEM -req -in "/etc/openvpn.csr" -CA "/etc/ca.crt" -CAkey "/etc/ca.key" -CAcreateserial -out "/etc/openvpn.crt"

    sudo cp openvpn-server.conf /etc/openvpn/server.conf
    sudo cp openvpn-client.conf /etc/openvpn/client.conf

    sudo mkdir -p /etc/openvpn/auth
    sudo cp ldap.conf /etc/openvpn/auth/ldap.conf

    sudo service openvpn restart
}

# Function to test VPN connection with OpenLDAP credentials
testVpnClient() {
    if [ -z "$1" ]; then
                read -p "Enter LDAP Username: " ldapUsername
            else
                ldapUsername="$1"
    fi
    read -s -p "Enter LDAP password: " ldapPassword

    echo -e "$ldapUsername\n$ldapPassword" | sudo openvpn --config /etc/openvpn/client.conf --auth-user-pass /dev/stdin
}
