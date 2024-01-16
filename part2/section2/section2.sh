#!/bin/bash

testDNS() {
    dig gl4.tn
    dig ldap.gl4.tn
    dig apache.gl4.tn
    dig openvpn.gl4.tn
}

ldapDNS() {
      ldapsearch -x -H ldap://ldap.gl4.tn -b "dc=ldap,dc=com" -D "cn=admin,dc=ldap,dc=com" -W
}

apacheDNS() {
      if [ -z "$1" ]; then
                    read -p "Enter LDAP Username: " ldapUsername
                else
                    ldapUsername="$1"
            fi

      read -s -p "Enter LDAP password: " ldapPassword
      curl -u $ldapUsername:$ldapPassword http://apache.gl4.tn
}

openvpnDNS() {
  if [ -z "$1" ]; then
                  read -p "Enter LDAP Username: " ldapUsername
              else
                  ldapUsername="$1"
      fi
      read -s -p "Enter LDAP password: " ldapPassword

      echo -e "$ldapUsername\n$ldapPassword" | sudo openvpn --config /etc/openvpn/client.conf --auth-user-pass /dev/stdin --remote openvpn.gl4.tn

}
