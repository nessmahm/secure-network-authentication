installBind9() {
  sudo apt update
  sudo apt install bind9 -y
}
createZoneFile() {
  #Change the addresses to your IP addresses
  sudo cp "$(dirname "$0")/gl4.tn.zone" /etc/bind/gl4.tn.zone
}

#optional
createReverseZoneFile() {
  # Change "99.56.168.192" to your IP address
  sudo cp "$(dirname "$0")/db.99.56.168.192" /etc/bind/db.99.56.168.192

}
updateMainConfigFile() {
  # Check files named.conf.local and named.conf.options
  sudo cp "$(dirname "$0")/named.conf.local" /etc/bind/named.conf.local
  sudo "$(dirname "$0")/named.conf.options" /etc/bind/named.conf.options
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
