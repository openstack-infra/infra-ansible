#!/usr/bin/env python

import yaml
import paramiko
import StringIO

KEY_LENGTH = 2048
HIERA_SSH_PARAMS = ['puppetmaster_root_rsa_key']
HIERA_COMMON_YAML_FILE = '/etc/puppet/hieradata/production/common.yaml'

out = StringIO.StringIO()
d = {}

for h in HIERA_SSH_PARAMS:
    k = paramiko.RSAKey.generate(KEY_LENGTH)
    k.write_private_key(out)
    d[h] = out.getvalue()

with open(HIERA_COMMON_YAML_FILE, "w") as f:
    yaml.safe_dump(d, f, explicit_start=True, default_flow_style=False)
