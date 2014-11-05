chmod +x *.sh
chmod 700 /root/gerritKey

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

#Currently gitProvision.yml may contain sensitive information, so it is copied in locally
cp /root/gitProvision.yml /root/sdu-test/provisions/gitProvision.yml

# echo "Is Ansible alive? Ping/Pong Request"
# ansible -i ~/ansible_hosts all -m ping

/root/ansible/bin/ansible-playbook /root/sdu-test/provisions/usersProvision.yml -i /root/ansible_hosts
/root/ansible/bin/ansible-playbook /root/sdu-test/provisions/fileProvision.yml -i /root/ansible_hosts
/root/ansible/bin/ansible-playbook /root/sdu-test/provisions/aptProvision.yml -i /root/ansible_hosts
/root/ansible/bin/ansible-playbook /root/sdu-test/provisions/pipProvision.yml -i /root/ansible_hosts
/root/ansible/bin/ansible-playbook /root/sdu-test/provisions/gitProvision.yml -i /root/ansible_hosts


mkdir -p /home/qatest/sdu-test-tempest/tools.cisco
mkdir -p /home/qatest/sdu-test-tempest/etc/configs.cisco
mkdir -p /home/qatest/sdu-test-tempets/etc/test-lists-nonadmin.baseline

cp /home/qatest/sdu-test-tempest-unstable/tools.cisco/* /home/qatest/sdu-test-tempest/tools.cisco
cp /home/qatest/sdu-test-tempest-unstable/etc/configs.cisco/* /home/qatest/sdu-test-tempest/etc/configs.cisco
cp /home/qatest/sdu-test-tempest-unstable/etc/test-lists-nonadmin.baseline/* /home/qatest/sdu-test-tempest/etc"

./prepareTempest.sh

exit 0

