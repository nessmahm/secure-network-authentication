# Section 2: Validation and Testing
### 2.1 Test DNS Resolution
Test DNS resolution for the configured services:

    dig gl4.tn
    dig ldap.gl4.tn
    dig apache.gl4.tn
    dig openvpn.gl4.tn

### Example: ldap auth

    ldapsearch -x -H ldap://ldap.gl4.tn -b "dc=gl4,dc=tn" -D "cn=admin,dc=gl4,dc=tn" -W

### Example: apache auth

    curl -u user1:password1 http://apache.gl4.tn


### Example: openvpn auth
