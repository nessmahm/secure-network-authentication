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

    sudo ldapmodify -x -D "cn=admin,dc=ldap,dc=com" -W -f certificates.ldif
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
# Configure LDAPS (LDAP over TLS)
configureLDAPS() {
    cert_dir="/etc/certificates"

    # Generate CA key and certificate
    sudo openssl genpkey -algorithm RSA -out "$cert_dir/ca.key"
    sudo openssl req -newkey rsa:2048 -nodes -keyout "$cert_dir/ca.key" -x509 -days 365 -out "$cert_dir/ca.crt"

    # Set proper ownership and permissions for CA key and certificate
    sudo chown openldap:openldap "$cert_dir/ca.crt"
    sudo chown openldap:openldap "$cert_dir/ca.key"
    sudo chmod 600 "$cert_dir/ca.crt"
    sudo chmod 600 "$cert_dir/ca.key"

    # Check if the TLS certificate file entry already exists
    if ! sudo ldapsearch -Q -Y EXTERNAL -H ldapi:/// -b "cn=config" "(olcTLSCertificateFile=$cert_dir/ca.crt)" | grep -q "olcTLSCertificateFile"; then
        # Add the TLS certificate file entry
       sudo ldapmodify -Y EXTERNAL -H ldapi:/// -f certinfo.ldif
    fi
    # Restart LDAP server
    sudo systemctl restart slapd
}

# Test secure LDAP with LDAPS
testLDAPS() {
    if [ -z "$1" ]; then
        read -p "Enter LDAP Username: " ldapUsername
    else
        ldapUsername="$1"
    fi

ldapsearch -x -H ldaps://127.0.0.1:389 -D "uid=$ldapUsername,ou=users,dc=ldap,dc=com" -W -b "dc=ldap,dc=com"
}
