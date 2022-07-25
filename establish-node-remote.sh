#!/bin/bash
# parameter 1 is host name in .ssh/config
# parameter 2 is new username to be set up.
echo 'Establishing new node '$1' with user '$2
echo 'Linux update...'
ssh $1 'apt update -y'
echo 'Set up new user '$2
ssh $1 'adduser --disabled-password --gecos '$2' '$2
ssh $1 'mkdir /home/'$2'/.ssh'
scp ~/.ssh/id_$2_rsa $1:/home/$2/.ssh/id_$2_rsa
scp ~/.ssh/id_$2_rsa.pub $1:/home/$2/.ssh/id_$2_rsa.pub
echo 'Adding user to sudoers...'
ssh $1 "echo $2'    ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/$2"
echo 'Setting up SSH keys...'
ssh $1 "cp /home/$2/.ssh/id_$2_rsa.pub /home/$2/.ssh/authorized_keys"
ssh $1 "chmod -R 0 /home/$2/.ssh"
ssh $1 "chmod -R u+rwx /home/$2/.ssh"
ssh $1 "chown -R $2 /home/$2/.ssh"
ssh $1 "chgrp -R $2 /home/$2/.ssh"
echo 'Installing Java JDK 11...'
ssh $1 "apt install -y openjdk-11-jdk-headless"
echo 'Installing Maven...'
cd ~
wget https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz
mv ~/apache-maven-3.8.6-bin.tar.gz /usr/share/apache-maven-3.8.6-bin.tar.gz
cd /usr/share
tar xvfz apache-maven-3.8.6-bin.tar.gz
rm apache-maven-3.8.6-bin.tar.gz
rm /usr/bin/mvn
ln -s /usr/share/apache-maven-3.8.6/bin/mvn /usr/bin/mvn
echo "Installing Net Tools..."
ssh $1 "apt install -y net-tools"
echo "Installing NCDU..."
ssh $1 "apt install -y ncdu"
echo 'New instance configuration complete.'