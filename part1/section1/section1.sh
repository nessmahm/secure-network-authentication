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


addCertificates() {
    # Directory to store certificates
    cert_dir="/etc/certificates"

    # Create the directory if it doesn't exist
    if [ ! -d "$cert_dir" ]; then
      sudo mkdir "$cert_dir"
    fi
    # Create the CA key and certificate
    sudo openssl genpkey -algorithm RSA -out "$cert_dir/ca.key"
    sudo openssl req -x509 -new -key "$cert_dir/ca.key" -out "$cert_dir/ca.crt" -subj "/CN=CA"

    # File containing user names (replace with your actual file path)
    user_list_file="user_list.txt"

    # Iterate through the user names in the file and create certificates
    while IFS= read -r username; do

      username=$(echo "$username" | tr -d '\r')

      echo "Creating certificate for $username"
      # Create user key
      sudo openssl genpkey -algorithm RSA -out "$cert_dir/$username.key"

      # Create certificate signing request (CSR)
      sudo openssl req -new -key "$cert_dir/$username.key" -out "$cert_dir/$username.csr" -subj "/CN=$username"

      # Sign the CSR with the CA to create the user certificate
      sudo openssl x509 -outform DER -req -in "$cert_dir/$username.csr" -CA "$cert_dir/ca.crt" -CAkey "$cert_dir/ca.key" -CAcreateserial -out "$cert_dir/$username.crt"
    done < "$user_list_file"
    ldapmodify -x -D "cn=admin,dc=ldap,dc=com" -W -f certificates.ldif

}

# Function to delete OpenLDAP users configuration
deleteOpenLDAPGroups() {
    ldapdelete -x -D "cn=admin,dc=ldap,dc=com" -W "ou=groups,dc=ldap,dc=com"
}

# Function to test user authentication in OpenLDAP
testAuthentication() {
    ldapsearch -x -D "uid=$1,ou=users,dc=ldap,dc=com" -W -b "dc=ldap,dc=com"
}

configureLDAPS() {
    # Generate private key
    sudo openssl genpkey -algorithm RSA -out "/etc/ldap.key"

    # Generate self-signed certificate
    sudo openssl req -newkey rsa:2048 -nodes -keyout "/etc/ldap.key" -x509 -days 365 -out "/etc/ldap.crt"

    sudo chown openldap:openldap /etc/ldap.crt
    sudo chown openldap:openldap /etc/ldap.key
    sudo chmod 600 /etc/ldap.crt
    sudo chmod 600 /etc/ldap.key

    # Configure LDAP server to use the generated certificate
    sudo ldapmodify -Y EXTERNAL -H ldapi:/// -f certinfo.ldif || true

    # Copy LDAPS configuration file
    sudo cp slapd.conf /etc/ldap/slapd.d/cn=config.ldif

    # Restart LDAP server
    sudo service slapd restart
}

# Function to test secure LDAP with LDAPS
testLDAPS() {
    ldapsearch -x -H ldaps://localhost:636 -D "uid=$1,ou=users,dc=ldap,dc=com" -W -b "dc=ldap,dc=com"
}