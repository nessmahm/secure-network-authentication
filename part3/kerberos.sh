installKerberos(){
  sudo apt-get update
  sudo apt-get install ldap-utils slapd
  #Nous avons choisis comme un nom de domaine : company.tn
}
configureHostname(){
  sudo nano /etc/hosts
  #add the hostname client0.company.tn for the current host
  #add the hostname client1.company.tn for the other machine host
}
connectKerberos(){
  su
  systemctl status krb5-kdc
  systemctl status krb5-admin-server  cd /etc/krb5kdc
  kadmin.local
}

addPricipals(){
  add_principal employer@COMPANY.TN
  add_principal root/admin@company.tn
  list_principals
}

addPolitics(){
  addent -password -p employer@COMPANY.TN -k 1 -e aes256-cts
  addent -password -p root/admin@COMPANY.TN -k 1 -e aes256-cts
  kutil

}


installOpenSSH(){
  sudo apt update
  sudo apt install openssh-server
  sudo systemctl restart sshd
  sudo systemctl status sshd
}
login(){
  #login and get the TGT
  kinit
  #les listes de tickets kerberos
  klist
}

obtainTicket(){
  kinit employer@company.tn
  kinit -T host/hostname@REALM
}