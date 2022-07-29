#!/bin/bash

ansible-galaxy collection install ansible.posix
#
USER_NAME=user
INVENTORY_PATH=./inventory/hosts
WIREGUARD_IP=192.168.122.22
ANSIBLE_PASSWORD=password
BECOME_PASSWORD=password

for PLAYBOOK in dns-master.yml wg.yml nginx-web.yml nginx-proxy.yml prometheus.yml zookeeper.yml # kafka.yml
do
    ansible-playbook ./playbooks/$PLAYBOOK -i $INVENTORY_PATH --user $USER_NAME --extra-vars "root_dir=$(pwd) wireguardIP=$WIREGUARD_IP ansible_password=$ANSIBLE_PASSWORD ansible_become_password=$BECOME_PASSWORD" 
done