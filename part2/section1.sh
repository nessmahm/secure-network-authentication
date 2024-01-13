#!/bin/bash

# Function to install OpenLDAP and LDAP utilities
configureDNS() {
#   installer le serveur DNS de référence, BIND
    sudo apt-get update
    sudo apt-get install bind9

#    La configuration principale de BIND9 est effectuée dans les fichiers suivant :
#
#    /etc/bind/named.conf
#    /etc/bind/named.conf.options
#    /etc/bind/named.conf.local

sudo nano /etc/bind/named.conf.options

#Décommentez le bloc fowarders et indiquez par exemple l'ip du serveur dns qui est donné par le serveur dhcp de votre box
#forwarders {
#		192.168.0.254;
#		8.8.8.8;
#	};

nano /etc/bind/named.conf.local

#On va déclarer une zone nommée local.lan
#Pour cela entrer
#
#zone "gl4.com" {
#    type master;
#    file "/etc/bind/db.votredomaine.com";
#};

#Puis il faut créer le fichier /etc/bind/gl4.com
sudo cp /etc/bind/db.local /etc/bind/gl4.com

}

