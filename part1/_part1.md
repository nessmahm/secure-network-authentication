# Part 1: Authentication with OpenLDAP, SSH, Apache, OpenVPN

## Overview

Part 1 of the project focuses on implementing a comprehensive authentication system using OpenLDAP, SSH, Apache, and OpenVPN. Each section contributes to the overall establishment of a secure and integrated authentication framework.

### [Section 1: Configuration of OpenLDAP](./section1/_section1.md)

This section is dedicated to setting up and configuring OpenLDAP, a central component for user authentication and authorization. The tasks include configuring an OpenLDAP server with five users and two groups ( teachers , students ), adding user information with X.509 certificates, ensuring successful user authentication, and testing the secure part of LDAP with LDAPS.

### [Section 2: Integration of SSH](./section2/_section2.md)

In this section, the focus shifts to enabling SSH authentication via OpenLDAP. Tasks include activating SSH authentication, restricting SSH access to users belonging to the appropriate group in OpenLDAP, and performing tests for an authorized and unauthorized user attempting SSH access.

### [Section 3: Integration of Apache](./section3/_section3.md)

The third section involves configuring Apache to utilize OpenLDAP for authentication. The tasks include setting up Apache, restricting web page access to members of specific groups in OpenLDAP, and conducting tests to validate access permissions for authorized and unauthorized users to a chosen website.

### [Section 4: Integration of OpenVPN](./section4/_section4.md)

The final section centers around the installation and configuration of OpenVPN, integrating it with OpenLDAP for authentication. Tasks include installing and configuring OpenVPN, testing VPN connections successfully using OpenLDAP information, and conducting tests for authorized and unauthorized clients attempting to establish a VPN tunnel.
