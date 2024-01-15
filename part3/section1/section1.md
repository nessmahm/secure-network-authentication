# Kerberos and OpenSSH Configuration

This repository provides a set of scripts to guide you through configuring a Kerberos Key Distribution Center (KDC) and OpenSSH server on a Debian-based machine. The steps aim to set up a basic Kerberos realm named `company.tn` and an OpenSSH server with Kerberos authentication.

## Steps and Explanation

### Step 1: Configure Hostname

- **Code:**
  ```bash
  source ./kerberos-host.sh && configureHostname
***Explanation***:
Edit the /etc/hosts file to add the hostname entries.
Set the static hostname to kdc.company.tn.
Add the hostname client.company.tn for the other machine host.


#### Step 2: Install Kerberos Components
- **Code:**
    ```bash
    source ./kerberos-host.sh && installKerberos


***Explanation***:
Update package information using sudo apt-get update.
Install necessary Kerberos components: krb5-kdc, krb5-admin-server, and krb5-config.
Set the domain name for the Kerberos realm as company.tn.

### Step 3: Create Password for Kerberos Database
- **Code:**
  ```bash
    source ./kerberos-host.sh && createPasswordForKerberosDB
***Explanation***:
Navigate to the Kerberos database directory.
Initialize the Kerberos realm with a password.

### Step 4: Start Kerberos Services
- **Code:**
  ```bash
    source ./kerberos-host.sh && connectToKerberos
***Explanation***:
Start and check the status of the Kerberos services.


### Step 5: Configure Kerberos Access Control
- **Code:**
  ```bash
    source ./kerberos-host.sh && configureKerberos
***Explanation***:
Edit the Kerberos Access Control List (ACL) file (/etc/krb5kdc/kadm5.acl) to define administrative access rules.
### Step 6: Add Kerberos Principals
- **Code:**
  ```bash
    source ./kerberos-host.sh && addPrincipals
***Explanation***:
Open the Kerberos admin interface (kadmin.local).
Add principals for users and administrators.
list principals shows the registered principals.

![list principals](../principals.png).

### Step 7: Add Encryption Types for Principals
- **Code:**
  ```bash
    ./kerberos-host.sh && addPolitics
***Explanation***:
Use ktutil to add encryption types for principals.
Verify the keytab file and list entries.

### Step 8: Install OpenSSH Server
- **Code:**
  ```bash
    source ./kerberos-host.sh && installOpenSSH
***Explanation***:
Update package information.
Install the OpenSSH server.
Uncomment and set GSSAPIAuthentication and GSSAPICleanUpCreadentials to yes in SSH configuration files.
Restart the SSH service.

### Step 9: Create User and Obtain TGT
- **Code:**
  ```bash
    source ./kerberos-host.sh && login
***Explanation***:
Add a user (e.g., employer) and grant sudo access.
Switch to the new user and obtain a Ticket Granting Ticket (TGT).

### Step 10: Obtain Kerberos Ticket
- **Code:**
  ```bash
    source ./kerberos-host.sh && obtainTicket
***Explanation***:
Obtain a Kerberos ticket for the employer principal.
### Step 11: Transfer File Using SCP
- **Code:**
  ```bash
    source ./kerberos-host.sh && sendFile
***Explanation***:
Create a sample file and use scp to transfer it.
***Instructions***
Uncomment and execute the desired steps in the script to perform specific tasks. Follow the comments within the script for additional configuration steps. Adapt the script according to your specific environment and requirements.


