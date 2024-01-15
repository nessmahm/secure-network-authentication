# Kerberos and OpenSSH Configuration

This repository provides a set of scripts to guide you through configuring a Kerberos Key Distribution Center (KDC) and OpenSSH server on a Debian-based machine. The steps aim to set up a basic Kerberos realm named `company.tn` and an OpenSSH server with Kerberos authentication.

## Steps and Explanation

### Step 1: Configure Hostname

- **Code:**
  ```bash
  sudo nano /etc/hosts
  hostnamectl --static set-hostname kdc.company.tn
***Explanation***:
Edit the /etc/hosts file to add the hostname entries.
Set the static hostname to kdc.company.tn.
Add the hostname client.company.tn for the other machine host.


#### Step 2: Install Kerberos Components
- **Code:**
    ```bash
    sudo apt-get update
    sudo apt install krb5-kdc krb5-admin-server krb5-config


***Explanation***:
Update package information using sudo apt-get update.
Install necessary Kerberos components: krb5-kdc, krb5-admin-server, and krb5-config.
Set the domain name for the Kerberos realm as company.tn.

### Step 3: Verify Kerberos Configuration
- **Code:**
  ```bash
    cat /etc/krb5.conf
***Explanation***:
Display the contents of the Kerberos configuration file (/etc/krb5.conf) to ensure correct setup.

### Step 4: Create Password for Kerberos Database
- **Code:**
  ```bash
    sudo sh -c 'cd /etc/krb5kdc'
    sudo krb5_newrealm
***Explanation***:
Navigate to the Kerberos database directory.
Initialize the Kerberos realm with a password.

### Step 5: Start Kerberos Services
- **Code:**
  ```bash
    sudo service krb5-kdc start
    sudo service krb5-kdc status
    sudo service krb5-admin-server start
    sudo service krb5-admin-server status
    sudo sh -c 'cd /etc/krb5kdc'
***Explanation***:
Start and check the status of the Kerberos services.


###Step 6: Configure Kerberos Access Control
- **Code:**
  ```bash
    echo "In configure"
    ls
    sudo nano /etc/krb5kdc/kadm5.acl
***Explanation***:
Edit the Kerberos Access Control List (ACL) file (/etc/krb5kdc/kadm5.acl) to define administrative access rules.
Step 7: Add Kerberos Principals
- **Code:**
  ```bash
    sudo kadmin.local
***Explanation***:
Open the Kerberos admin interface (kadmin.local).
Add principals for users and administrators.
Step 8: Add Encryption Types for Principals
- **Code:**
  ```bash
    sudo ktutil
***Explanation***:
Use ktutil to add encryption types for principals.
Verify the keytab file and list entries.

### Step 9: Install OpenSSH Server
- **Code:**
  ```bash
    sudo apt update
    sudo apt install openssh-server
    sudo nano /etc/ssh/sshd_config
    sudo nano /etc/ssh/ssh_config
    sudo service ssh restart
    sudo service ssh status
***Explanation***:
Update package information.
Install the OpenSSH server.
Uncomment and set GSSAPIAuthentication and GSSAPICleanUpCreadentials to yes in SSH configuration files.
Restart the SSH service.

### Step 10: Create User and Obtain TGT
- **Code:**
  ```bash
    su -l employer
    kinit
    klist
***Explanation***:
Add a user (e.g., employer) and grant sudo access.
Switch to the new user and obtain a Ticket Granting Ticket (TGT).

### Step 11: Obtain Kerberos Ticket
- **Code:**
  ```bash
    kinit employer@company.tn
    kinit -T host/hostname@REALM
***Explanation***:
Obtain a Kerberos ticket for the employer principal.
### Step 12: Transfer File Using SCP
- **Code:**
  ```bash
    echo 'hello' > file
    sudo scp file
***Explanation***:
Create a sample file and use scp to transfer it.
***Instructions***
Uncomment and execute the desired steps in the script to perform specific tasks. Follow the comments within the script for additional configuration steps. Adapt the script according to your specific environment and requirements.


