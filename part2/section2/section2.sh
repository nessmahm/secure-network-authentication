testDNS() {
    dig gl4.tn
    dig ldap.gl4.tn
    dig apache.gl4.tn
    dig openvpn.gl4.tn
}

ldapDNS() {
      ldapsearch -x -H ldap://ldap.gl4.tn -b "dc=gl4,dc=tn" -D "cn=admin,dc=gl4,dc=tn" -W
}

apacheDNS() {
      curl -u user1:password1 http://apache.gl4.tn
}

openvpnDNS() {

}
