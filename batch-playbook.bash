#!/bin/bash

ansible-playbook ./playbooks/dns-master.yml -i ./inventory/hosts --user ansible --ask-pass --ask-become-pass
ansible-playbook ./playbooks/wg.yml -i ./inventory/hosts --user ansible --ask-pass --ask-become-pass
ansible-playbook ./playbooks/nginx-web.yml -i ./inventory/hosts --user ansible --ask-pass --ask-become-pass
ansible-playbook ./playbooks/nginx-proxy.yml -i ./inventory/hosts --user ansible --ask-pass --ask-become-pass
ansible-playbook ./playbooks/prometheus.yml -i ./inventory/hosts --user ansible --ask-pass --ask-become-pass
