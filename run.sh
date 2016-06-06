#!/bin/bash
ansible-playbook -i hosts setup_openstack_resources.yml -e "@resources.yml"
ansible-playbook -i inventory/openstack.py site.yml -e "@infra_config.yml"
