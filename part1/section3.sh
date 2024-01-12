#!/bin/bash

# Section 3: Integration of Apache

# Function to install Apache and required modules
installApache() {
    sudo apt-get update
    sudo apt-get install -y apache2
    sudo a2enmod authnz_ldap
    sudo systemctl restart apache2

}

# Function to configure Apache for OpenLDAP authentication
configureApacheOpenLDAP() {
    # Enable LDAP authentication module
    echo "Please Enter LDAP Password :"

    read -s LDAP_PASSWORD
    # Configure Apache to use OpenLDAP for authentication
    # Update the LDAP server and group information
    sudo tee /etc/apache2/sites-available/000-default.conf > /dev/null <<EOF
    <VirtualHost *:443>
        DocumentRoot /var/www/html
        <Directory /var/www/html>
            AuthType Basic
            AuthName "LDAP Authentication"
            AuthBasicProvider ldap
            AuthLDAPURL "ldap://localhost/dc=ldap,dc=com?uid"
            AuthLDAPBindDN "cn=admin,dc=ldap,dc=com"
            AuthLDAPBindPassword $LDAP_PASSWORD
            Require ldap-group cn=teachers,ou=groups,dc=ldap,dc=com
        </Directory>
    </VirtualHost>
EOF

    # Restart Apache service
    sudo systemctl restart apache2
}

# Function to test web access for an authorized and unauthorized user
testWebAccess() {
    curl -u "$1":"$2" http://localhost
}

# Uncomment and execute the functions as needed
# configureApacheOpenLDAP
# testWebAccess
