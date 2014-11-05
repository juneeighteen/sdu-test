echo "bootstrap.sh called to install Ansible"
echo "installing python-yaml"
apt-get install python-yaml -y

echo "installing python-paramiko"
apt-get install python-paramiko -y

echo "installing python-jinja2"
apt-get install python-jinja2 -y

echo "installing python-simplejson"
apt-get install python-simplejson -y

echo "installing sshpass"
apt-get install sshpass -y

echo "Cloning Ansible from Github"
git clone git://github.com/ansible/ansible.git

echo "Launching Ansible. This may take a few minutes."
cd ./ansible

echo "Downloading submodules"
git submodule update --init --recursive

echo "Sourcing Ansible environment"
source ./hacking/env-setup

echo "Writing localhost to ~/ansible_hosts"
echo "localhost ansible_connection=local" > ~/ansible_hosts

exit 0
# echo "Is Ansible alive? Ping/Pong Request"
# ansible -i ~/ansible_hosts all -m ping

