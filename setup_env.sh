#!/bin/bash

# Install virtualenv package if not installed
if [ ! -f /usr/bin/pip ]; then
    sudo -E apt-get install python-pip
fi

# Create infra-ansible virtual environment
pip install virtualenv
virtualenv venv
source venv/bin/activate
pip install -r requirements.txt

# Create inventory folder
if [ ! -d inventory ]; then
    mkdir inventory
fi

# Install Ansible openstack inventory
/usr/bin/wget -N https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/openstack.py -O inventory/openstack.py
chmod +x inventory/openstack.py
