#!/bin/bash

configureHostname(){
  sudo nano /etc/hosts
  hostnamectl --static set-hostname client.company.tn
  #add the hostname kdc.company.tn for the server host
  #add the hostname client.company.tn for the current machine
}

installKerberos(){
  sudo apt-get update
  sudo apt install krb5-user
}


installOpenSSH(){
  sudo apt update
  sudo apt install openssh-server
  #Uncomment the lines of GSSAPIAuthentication and GSSAPICleanUpCreadentials and set them to yes
  sudo nano /etc/ssh/sshd_config
  sudo nano /etc/ssh/ssh_config
  sudo systemctl restart sshd
  sudo systemctl status sshd
}
login(){
  #login and get the TGT
  kinit
  #les listes de tickets kerberos
  klist
}

receiveFile(){
  sudo scp kdc.company.tn:file .
}

