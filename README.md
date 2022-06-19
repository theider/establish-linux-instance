# establish-linux-instance
Every time I create a new Linux instance I find myself doing a common series of tasks. This process and scripts was created to simplify that process.

The first instance in the project family (mytprint will be used as the example project in this readme) needs to create a new SSH key.

ssh-keygen

For project mytprint use naming convention "id_mytprint_rsa".

After the instance is created add an entry to .ssh/config for the new host with root access using that key:

Host mytprint-mysql
    HostName 161.35.7.175
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/id_mytprint_rsa
    User root

After adding the config entry run the script establish-node-remote.sh hostname username

./establish-node-remote.sh mytprint-elasticsearch mytprint

After that you should be able to go back into the .ssh/config and update the user from root to the new username mytprint.

You should do an APT upgrade and then reboot.
