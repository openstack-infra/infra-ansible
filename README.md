Instructions
============

1. Run ``bash setup_env.sh``
2. Run ``source /opt/stack/ansible/hacking/env-setup``
3. Run ``cp infra_config.yml.sample infra_config.yml``
4. Edit infra_config.yml and put your environment values
5. Run ``ansible-playbook -i <ansible repo folder>/plugins/inventory/openstack.py -e "@infra_config.yml" provision_infra_servers.yml``
6. Run ``ansible-playbook -i <ansible repo folder>/plugins/inventory/openstack.py -e "@infra_config.yml" site.yml``
