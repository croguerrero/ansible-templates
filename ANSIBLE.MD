sudo yum install epel-release
sudo yum install ansible

sudo useradd ansible
sudo passwd ansible

sudo su - ansible

ssh-copy-id workstation

ssh cloud_user@control

ansible-playbook -i /home/ansible/inventory git-install.yml   #install by ansible 

# copy ssh key to all hosts
ssh-keygen
ssh-copy-id node1
ssh-copy-id node2
touch /home/ansible/inventory
echo "node1" >> /home/ansible/inventory
echo "node2" >> /home/ansible/inventory

# Add access 
sudo visudo
ansible    ALL=(ALL)       NOPASSWD: ALL

# Verify access
ansible -i /home/ansible/inventory node1 -m ping > /home/ansible/output

# Create user account 
ansible dbsystems -b -m user -a "name=consultant"
ansible dbsystems -b -m user -a "name=supervisor"

# Place Key Files in the coorect location 
ansible dbsystems -b -m file -a "path=/home/consultant/.ssh state=directory owner=consultant group=consultant mode=0755"
ansible dbsystems -b -m copy -a "src=/home/ansible/keys/consultant/authorized_keys dest=/home/consultant/.ssh/authorized_keys mode=0600 owner=consultant group=consultant"
ansible dbsystems -b -m file -a "path=/home/supervisor/.ssh state=directory owner=supervisor group=supervisor mode=0755"
ansible dbsystems -b -m copy -a "src=/home/ansible/keys/supervisor/authorized_keys dest=/home/supervisor/.ssh/authorized_keys mode=0600 owner=supervisor group=supervisor"

# Ensure auditd is enabled and running all hosts
ansible all -b -m service -a "name=auditd state=started enabled=yes"

#
ansible all -i inventory -m setup -a "filter=*ipv4*" -u croguerrero -k
ansible localhost -m setup -a "filter=*ipv4*" -u croguerrero