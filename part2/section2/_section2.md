# Section 2: Validation and Testing
### 2.1 Test DNS Resolution
Test DNS resolution for the configured services:

    dig gl4.tn
    dig ldap.gl4.tn
    dig apache.gl4.tn
    dig openvpn.gl4.tn

### Example: ldap auth
Now we can use ldap.gl4.tn as the ldap server URL, and we used the ldapsearch command to test the ldap server.
~~~sh
  source ./section2.sh && ldapDNS
~~~
![img_1.png](../../images/part2/section2/img1.png)
### Example: apache auth
We can use apache.gl4.tn as the apache server URL, and we used the curl command to test the apache server.
~~~sh
  source ./section2.sh && apacheDNS
~~~~
![img_2.png](../../images/part2/section2/img2.png)


![img_3.png](../../images/part2/section2/img3.png)

### Example: openvpn auth
We can use openvpn.gl4.tn as the remote server URL, and we used the openvpn command to test the openvpn server.
~~~sh
  source ./section2.sh && openvpnDNS
~~~
![img_4.png](../../images/part2/section2/img4.png)
