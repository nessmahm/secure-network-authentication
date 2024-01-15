# Kerberos Authentication - Overview

## Project Objective
The primary goal of this project is to establish a robust authentication and network services infrastructure using industry-standard technologies such as OpenLDAP, SSH, Apache, OpenVPN, DNS, and Kerberos.
This project aims to showcase proficiency in configuring and securing diverse services to ensure a resilient and fully functional network environment.

### Used Technologies

- <span><img align="center" src="https://www.axonius.com/hubfs/Adapter%20Logos/OpenLDAP%20Logo.png" height="40" width="40" /></span>
  **OpenLDAP:** An open-source implementation of the Lightweight Directory Access Protocol (LDAP), used for centralized management of user accounts and authentication information.
- <span><img align="center" src="https://cdn-icons-png.flaticon.com/512/5136/5136897.png" height="40" width="40" /></span>
  **SSH (Secure Shell):** A cryptographic network protocol used for secure communication over an unsecured network, providing a secure way to access and manage remote devices.
- <span><img align="center" src="https://britewire.com/wp-content/uploads/apache-http-server-300x300.jpg" height="40" width="40" /></span>
  **Apache:** The widely used open-source web server software, crucial for hosting and serving web content securely.
- <span><img align="center" src="https://usermanual.vtenext.com/uploads/images/gallery/2023-03/openvpn-logo.jpg" height="40" width="40" /></span>
  **OpenVPN:** An open-source VPN (Virtual Private Network) solution, facilitating secure communication over the internet by creating a private tunnel.
- <span><img align="center" src="https://cdn-images-1.medium.com/max/599/0*KNOfmhs1x_-c2v4U.jpg" height="40" width="40" /></span>
  **DNS (Domain Name System):** A hierarchical decentralized naming system translating domain names into IP addresses, crucial for resolving web addresses to network resources.
- <span><img align="center" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUgsK-4bNt8VqwyLZTlJvD6dkQkyP67ElV7Dg8KW0DrjDfX3ZpDGouBMPakWXXUWW0KCg&usqp=CAU" height="40" width="40" /></span>
  **Kerberos:** A network authentication protocol designed to provide strong authentication for client/server applications using secret-key cryptography. These technologies form the backbone of the project.


## Project Overview
The project encompasses three main parts, each focusing on specific aspects of network services and authentication:

#### [Part 1: Authentication with OpenLDAP, SSH, Apache, OpenVPN](./part1/_part1.md)
Establishing a robust authentication framework using OpenLDAP, SSH, Apache, and OpenVPN. OpenLDAP serves as the centralized user directory, SSH provides secure remote access, Apache is configured for web authentication, and OpenVPN is integrated for secure virtual private network connections.

#### [Part 2: Management of Network Services with DNS](./part2/_part2.md)
Configuring and validating the Domain Name System (DNS) to efficiently manage network services. A separate DNS server (Bind) is set up for domain resolution, with added DNS records for OpenLDAP, Apache, and OpenVPN servers, ensuring seamless name-to-IP address translation.

#### [Part 3: Authentication with Kerberos](./part3/_part3.md)
Introducing Kerberos for enhanced authentication security. A dedicated Kerberos server is installed and configured, adding principals and password policies for users. One of the services (OpenLDAP, SSH, Apache, or OpenVPN) is selected for Kerberos integration, providing an additional layer of authentication.

