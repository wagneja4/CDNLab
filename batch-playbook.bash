#!/bin/bash

ansible-playbook ./playbooks/ansible.yml -i ./inventory/hosts --user ansible --ask-pass --ask-become-pass
ansible-playbook ./playbooks/dns-master.yml -i ./inventory/hosts --user ansible --ask-pass --ask-become-pass
ansible-playbook ./playbooks/nginx.yml -i ./inventory/hosts --user ansible --ask-pass --ask-become-pass
ansible-playbook ./playbooks/wg.yml -i ./inventory/hosts --user ansible --ask-pass --ask-become-pass
