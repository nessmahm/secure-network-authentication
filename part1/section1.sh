#!/bin/bash

# Function to install OpenLDAP and LDAP utilities
installOpenLDAP() {
    sudo apt-get update
    sudo apt-get install -y slapd ldap-utils
}

# Function to reconfigure OpenLDAP
reconfigureOpenLDAP() {
    sudo dpkg-reconfigure slapd
    sudo systemctl start slapd
}

# Function to add Organizational Units to OpenLDAP
addOpenLDAPOrganizationalUnits() {
    sudo ldapadd -x -D "cn=admin,dc=ldap,dc=com" -W -f organization.ldif
}

# Function to add users to OpenLDAP
addOpenLDAPUsers() {
    sudo ldapadd -x -D "cn=admin,dc=ldap,dc=com" -W -f users.ldif
}

# Function to delete OpenLDAP users configuration
deleteOpenLDAPUsers() {
    ldapdelete -x -D "cn=admin,dc=ldap,dc=com" -W "dc=ldap,dc=com"
}

# Function to test user authentication in OpenLDAP
testAuthentication() {
    ldapsearch -x -D "uid=$1,ou=users,dc=ldap,dc=com" -W -b "dc=ldap,dc=com"
}

# Function to test secure LDAP with LDAPS
testLDAPS() {
    # Install necessary packages for LDAPS
    sudo apt install gnutls-bin ssl-cert

    # Generate self-signed certificate
    sudo certtool --generate-privkey --bits 4096 --outfile /etc/ssl/private/mycakey.pem
    sudo certtool --generate-self-signed \
        --load-privkey /etc/ssl/private/mycakey.pem \
        --outfile /usr/local/share/ca-certificates/mycacert.crt

    sudo update-ca-certificates
    sudo certtool --generate-privkey \
        --bits 2048 \
        --outfile /etc/ldap/ldap01_slapd_key.pem

    sudo certtool --generate-certificate \
        --load-privkey /etc/ldap/ldap01_slapd_key.pem \
        --load-ca-certificate /etc/ssl/certs/mycacert.pem \
        --load-ca-privkey /etc/ssl/private/mycakey.pem \
        --outfile /etc/ldap/ldap01_slapd_cert.pem

    sudo chgrp openldap /etc/ldap/ldap01_slapd_key.pem
    sudo chmod 0640 /etc/ldap/ldap01_slapd_key.pem
    sudo ldapmodify -Y EXTERNAL -H ldapi:/// -f certinfo.ldif

    # Update SLAPD_SERVICES in slapd configuration

    sudo systemctl restart slapd

    # Test LDAPS
    ldapsearch -H ldaps://localhost  -D "uid=$1,ou=users,dc=ldap,dc=com" -W -b "dc=ldap,dc=com"
}

# Uncomment and execute the functions as needed
# installOpenLDAP
# reconfigureOpenLDAP
# addOpenLDAPOrganizationalUnits
# addOpenLDAPUsers
# deleteOpenLDAPUsers
# testAuthentication <username>
testLDAPS mohamed.dhouib