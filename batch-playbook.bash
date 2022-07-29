#!/bin/bash
#I use ansible.posix module instead of inlining/replacing existing config by myself. So I need this package
ansible-galaxy collection install ansible.posix
#
USER_NAME=user
ROOT_DIRECTORY=$(pwd)
INVENTORY_PATH=$ROOT_DIRECTORY/inventory/hosts
# this should be replaced by domain name (in wg.conf files), but unfortunately wireguard doesnt support domain names (that I know of)
WIREGUARD_IP=192.168.122.22
# I should be using sshkeys. I ansible setup playbook (configuring ssh connection, disabling password authentication and etc.),
# but I chose not to. This is a matter of system security, so I would abide by security policy in the organisation.
ANSIBLE_PASSWORD=password
BECOME_PASSWORD=password

for PLAYBOOK in bind.yml wireguard.yml nginx-web.yml nginx-proxy.yml prometheus.yml zookeeper.yml
do
    ansible-playbook ./playbooks/$PLAYBOOK -i $INVENTORY_PATH --user $USER_NAME --extra-vars "root_dir=$ROOT_DIRECTORY wireguardIP=$WIREGUARD_IP ansible_password=$ANSIBLE_PASSWORD ansible_become_password=$BECOME_PASSWORD" 
done