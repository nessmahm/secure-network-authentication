#!/bin/bash

configureHostname(){
  sudo nano /etc/hosts
  hostnamectl --static set-hostname kdc.company.tn
  #add the hostname kdc.company.tn for the current host
  #add the hostname client.company.tn for the other machine host
}

installKerberos(){
  sudo apt-get update
  sudo apt install krb5-kdc krb5-admin-server krb5-config
  #Nous avons choisi comme un nom de domaine : company.tn

  #Verify the configuration
  cat /etc/krb5.conf
}

createPasswordForKerberosDB(){
  #create a password for the kerberos database
  sudo sh -c 'cd /etc/krb5kdc'
  sudo krb5_newrealm
}
connectKerberos(){
  sudo service krb5-kdc start
  sudo service krb5-kdc status
  sudo service krb5-admin-server start
  sudo service krb5-admin-server status
  sudo sh -c 'cd /etc/krb5kdc'

}

configureKerberos(){
  #configure the kerberos database
  echo "In configure"
  ls
  sudo nano /etc/krb5kdc/kadm5.acl
  #Uncomment the line with the admin principal

}
addPrincipals(){
  echo "In addPrincipals"
  sudo kadmin.local
  #Execute this commands in kadmin.local
   #add_principal employer@COMPANY.TN
   #add_principal rh@COMPANY.TN
   #add_principal root/admin@company.tn
   #list_principals
   #exit
  sudo strings /var/lib/krb5kdc/principal
  service krb5-kdc restart
  service krb5-admin-server restart

}

addPolitics(){
  sudo ktutil
  #sudo addent -password -p employer@COMPANY.TN -k 1 -e aes256-cts
  #sudo wkt /etc/krb5kdc/kadm5.keytab
  #q
  sudo ktutil
  #addent -password -p root/admin@COMPANY.TN -k 1 -e aes256-cts
  #wkt /etc/krb5kdc/kadm5.keytab
  #rkt /etc/krb5kdc/kadm5.keytab
  #l
  #q
   #addent -password -p rh@COMPANY.TN -k 1 -e aes256-cts
    #wkt /etc/krb5kdc/kadm5.keytab
    #rkt /etc/krb5kdc/kadm5.keytab
    #l
    #exit
  file /etc/krb5kdc/kadm5.keytab
  klist -kte kadm5.keytab
}


installOpenSSH(){
  sudo apt update
  sudo apt install openssh-server
  #Uncomment the lines of GSSAPIAuthentication and GSSAPICleanUpCreadentials and set them to yes
  sudo nano /etc/ssh/sshd_config
  sudo nano /etc/ssh/ssh_config
  sudo service ssh restart
  sudo service ssh status
}
login(){
  #execute this commands first
  #sudo adduser employer
  #sudo usermod -aG sudo employer
  su -l employer
  #login and get the TGT
  #sudo ssh kdc.company.tn
  kinit
  #les listes de tickets kerberos
  klist
}

obtainTicket(){
  kinit employer@company.tn
  kinit -T host/hostname@REALM
}

sendFile(){
  echo 'hello' > file
  sudo scp file
  }

#configureHostname
#installKerberos
#createPasswordForKerberosDB
#connectKerberos
#configureKerberos
#addPrincipals
#addPolitics
#installOpenSSH
#login
#obtainTicket
#sendFile