#!/bin/bash
#
# Install python pip & virtualenv packages & then create
# a python virtualenv & install the infra-ansible dependencies in it

# check platform prerequisites
case $(uname) in
  Linux)
    # check if the apt-get executable is available
    if hash apt-get 2>/dev/null; then
        # check for & install the various packages
        hash pip 2>/dev/null || { sudo -E apt-get install -y python-pip; }
        [[ -z "$(dpkg -l python-dev | grep '^ii  python-dev')" ]] && sudo -E apt-get install -y python-dev
        hash virtualenv 2>/dev/null || { sudo pip install virtualenv; }
    elif hash yum 2>/dev/null; then
        # on RHEL/CentOS, pip is installed during the virtualenv setup
        hash virtualenv 2>/dev/null || { sudo -E yum install -y python-virtualenv python-devel gcc gcc-c++; }
        hash wget 2>/dev/null || { sudo -E yum install -y wget; }
    else
        echo "ERROR: Zoinks, I only know about Debian and RHEL"
        exit 1
    fi

    ;;
  Darwin)
    hash pip 2>/dev/null || { echo "ERROR: pip isn't installed, please rectify this!" ; exit 1; }
    hash virtualenv 2>/dev/null || { sudo pip install virtualenv; }
    ;;
esac


# Create a fresh infra-ansible virtual environment
[[ -e venv ]] && rm -rf venv
virtualenv venv
source venv/bin/activate
pip install -r requirements.txt

# Create inventory folder
if [[ ! -d inventory ]]; then
    mkdir inventory
fi

# Install roles dependencies from requirements.yml
ansible-galaxy install -r requirements.yml

# Install Ansible openstack inventory
wget https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/openstack.py -O inventory/openstack.py
chmod +x inventory/openstack.py
