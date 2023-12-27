#!/bin/bash

# Section 1: Configuration of OpenLDAP

function installOpenLDAP {
    sudo apt-get update
    sudo apt-get install -y slapd ldap-utils
}

function configureOpenLDAP {
    # You will be prompted to set a password for the admin user during installation
    # Provide a password and remember it for later use

    # 1.1 Configure OpenLDAP with at least two users and two groups
    sudo ldapadd -x -D "cn=admin,dc=example,dc=com" -W -f users.ldif

    # Create a file add_users.ldif with the user entries (as mentioned in the previous response)
}

function testAuthentication {
    # 1.3 Ensure users can authenticate successfully
    # Test authentication using ldapwhoami
    ldapwhoami -x -D "uid=user1,ou=people,dc=example,dc=com" -W
}

function testLDAPS {
    # 1.4 Test secure LDAP with LDAPS
    # Enable LDAPS in slapd.conf or use a separate LDAPS configuration file
    # For testing, you can use self-signed certificates or obtain valid certificates
    # and update the paths in the LDAPS configuration

    # Install necessary packages for LDAPS
    sudo apt-get install -y gnutls-bin

    # Test LDAPS
    ldapsearch -H ldaps://localhost -D "uid=user1,ou=people,dc=example,dc=com" -W
}

# Execute the functions
installOpenLDAP
configureOpenLDAP
testAuthentication
testLDAPS
