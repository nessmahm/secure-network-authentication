#!/bin/bash

# Section 3: Integration of Apache

# Function to install Apache and required modules
installApache() {
    sudo apt-get update
    sudo apt-get install -y apache2
    sudo a2enmod proxy_http
    sudo a2enmod authnz_ldap
    sudo systemctl restart apache2

}

# Function to configure Apache for OpenLDAP authentication
configureApacheOpenLDAP() {
    sudo cat apache.conf | sudo tee /etc/apache2/sites-available/000-default.conf
    # Restart Apache service
    sudo systemctl restart apache2
}

# Function to test web access for an authorized and unauthorized user
testWebAccess() {
    curl -u "$1":"$2" http://localhost
}
