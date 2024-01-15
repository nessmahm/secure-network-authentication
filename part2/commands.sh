installBind9() {
  sudo apt update
  sudo apt install bind9 -y
}
createZoneFile() {
  sudo nano /etc/bind/gl4.tn.zone
  #Check the file gl4.tn.zone
}

#optional
createReverseZoneFile() {
  # Change "99.56.168.192" to your IP address
  sudo nano /etc/bind/db.99.56.168.192
  #Check the file db.99.56.168.192

}
updateMainConfigFile() {
  # Check files named.conf.local and named.conf.options
  sudo nano /etc/bind/named.conf.local
  sudo nano /etc/bind/named.conf.options
}

checkConfigFiles() {
  sudo named-checkconf /etc/bind/named.conf.local
  sudo named-checkconf /etc/bind/named.conf
}

verifyZoneFile() {
  sudo named-checkzone gl4.net /etc/bind/gl4.tn.zone
}


restartBind9() {
  sudo systemctl restart bind9
}

testDNS() {
  dig gl4.tn
}
