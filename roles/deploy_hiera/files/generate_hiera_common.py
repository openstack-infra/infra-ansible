#!/usr/bin/env python

import paramiko
import random
import string
import StringIO
import yaml

KEY_LENGTH = 2048
HIERA_SSH_PARAMS = [('puppetmaster_root_rsa_key', 'puppetmaster_root_rsa_pub_key'),
                    ('jenkins_ssh_private_key', 'jenkins_ssh_public_key'),
                    ('zuul_ssh_private_key_contents', 'zuul_ssh_public_key_contents'),
                    ('gerrit_ssh_rsa_key_contents', 'gerrit_ssh_rsa_pubkey_contents'),
                    ('gerrit_project_ssh_rsa_key_contents', 'gerrit_project_ssh_rsa_pubkey_contents')]
HIERA_PASSWORD_PARAMS = ['jenkins_jobs_password', 'gerrit_mysql_password']
HIERA_COMMON_YAML_FILE = '/etc/puppet/hieradata/production/common.yaml'

d = {}

for h in HIERA_SSH_PARAMS:
    out = StringIO.StringIO()
    k = paramiko.RSAKey.generate(KEY_LENGTH)
    k.write_private_key(out)
    d[h[0]] = out.getvalue()
    d[h[1]] = k.get_name() + ' ' + k.get_base64()
    out.close()

for h in HIERA_PASSWORD_PARAMS:
    d[h] = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(12))


with open(HIERA_COMMON_YAML_FILE, "w") as f:
    yaml.safe_dump(d, f, explicit_start=True, default_flow_style=False)
