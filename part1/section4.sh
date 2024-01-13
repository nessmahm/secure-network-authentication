#!/bin/bash

# Section 4: Authentication SSH

# Function to enable SSH authentication via OpenLDAP
 InstallAndConfigureOpenVPN() {
  #Install OpenVPN
sudo apt-get update
sudo apt-get install openvpn
sudo apt-get install libpam-ldapd

}
