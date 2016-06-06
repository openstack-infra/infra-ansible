Instructions
============

1. Run ``source setup_env.sh``
3. Source your OpenStack cloud environment variables rc file
3. Run ``cp resources.yml.sample resources.yml``
4. Edit resources.yml and put your environment values
5. Run ``bash run.sh``

Notes
=====

In resources.yml you may specify public key file instead of public key content, in the following way:

    keypairs:
      - name: my_key_file
        public_key_file: /home/<my_user>/.ssh/<key_file>

Do not specify both 'public_key' and 'public_key_file', as they are mutual exclusive variables in Ansible.
