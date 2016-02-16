#!/bin/bash
ansible-playbook -i hosts provision_infra_servers.yml -e "@infra_config.yml"
ansible-playbook -i inventory/openstack.py site.yml -e "@infra_config.yml"
