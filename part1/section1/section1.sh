#!/bin/bash

# Install OpenLDAP and LDAP utilities
installOpenLDAP() {
    sudo apt-get update
    sudo apt-get install -y slapd ldap-utils
}

# Reconfigure OpenLDAP
reconfigureOpenLDAP() {
    sudo dpkg-reconfigure slapd

    sudo systemctl start slapd
}

# Add Organizational Units to OpenLDAP
addOpenLDAPOrganizationalUnits() {
    sudo ldapadd -x -D "cn=admin,dc=ldap,dc=com" -W -f organization.ldif
}

# Add users to OpenLDAP
addOpenLDAPUsers() {
    sudo ldapadd -x -D "cn=admin,dc=ldap,dc=com" -W -f users.ldif
}

# Add certificates to OpenLDAP users
addCertificates() {
    cert_dir="/etc/certificates"

    if [ ! -d "$cert_dir" ]; then
        sudo mkdir "$cert_dir"
    fi

    sudo openssl genpkey -algorithm RSA -out "$cert_dir/ca.key"
    sudo openssl req -x509 -new -key "$cert_dir/ca.key" -out "$cert_dir/ca.crt" -subj "/CN=CA"

    while IFS= read -r username; do
        username=$(echo "$username" | tr -d '\r')

        echo "Creating certificate for $username"
        sudo openssl genpkey -algorithm RSA -out "$cert_dir/$username.key"
        sudo openssl req -new -key "$cert_dir/$username.key" -out "$cert_dir/$username.csr" -subj "/CN=$username"
        sudo openssl x509 -outform DER -req -in "$cert_dir/$username.csr" -CA "$cert_dir/ca.crt" -CAkey "$cert_dir/ca.key" -CAcreateserial -out "$cert_dir/$username.crt"
    done < "user_list.txt"

    ldapmodify -x -D "cn=admin,dc=ldap,dc=com" -W -f certificates.ldif
}

# Delete OpenLDAP groups configuration
deleteOpenLDAPGroups() {
    ldapdelete -x -D "cn=admin,dc=ldap,dc=com" -W "ou=groups,dc=ldap,dc=com"
}

# Test user authentication in OpenLDAP
testAuthentication() {
    read -p "Enter LDAP username: " ldapUsername
    ldapsearch -x -D "uid=$ldapUsername,ou=users,dc=ldap,dc=com" -W -b "dc=ldap,dc=com"
}

# Configure LDAPS (LDAP over TLS)
configureLDAPS() {
    sudo openssl genpkey -algorithm RSA -out "/etc/ldap.key"
    sudo openssl req -newkey rsa:2048 -nodes -keyout "/etc/ldap.key" -x509 -days 365 -out "/etc/ldap.crt"

    sudo chown openldap:openldap /etc/ldap.crt
    sudo chown openldap:openldap /etc/ldap.key
    sudo chmod 600 /etc/ldap.crt
    sudo chmod 600 /etc/ldap.key

    sudo ldapmodify -Y EXTERNAL -H ldapi:/// -f certinfo.ldif || true

    sudo cp slapd.conf /etc/ldap/slapd.d/cn=config.ldif

    sudo service slapd restart
}

# Test secure LDAP with LDAPS
testLDAPS() {
    if [ -z "$1" ]; then
        read -p "Enter LDAP Username: " ldapUsername
    else
        ldapUsername="$1"
    fi

    ldapsearch -x -H ldaps://localhost:636 -D "uid=$ldapUsername,ou=users,dc=ldap,dc=com" -W -b "dc=ldap,dc=com"
}
