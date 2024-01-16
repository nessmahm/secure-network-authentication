# Section 2: Validation and Testing
### 2.1 Test DNS Resolution
Test DNS resolution for the configured services:

    dig gl4.tn
    dig ldap.gl4.tn
    dig apache.gl4.tn
    dig openvpn.gl4.tn

### Example: ldap auth
~~~sh
  source ./section2.sh && ldapDNS
~~~
![img_1.png](../../images/part2/section2/img1.png)
### Example: apache auth
~~~sh
  source ./section2.sh && apacheDNS
~~~~
![img_2.png](../../images/part2/section2/img2.png)


![img_3.png](../../images/part2/section2/img3.png)

### Example: openvpn auth
~~~sh
  source ./section2.sh && openvpnDNS
~~~
![img_4.png](../../images/part2/section2/img4.png)
