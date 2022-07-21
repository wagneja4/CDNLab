#!/bin/bash
# --ask-become-pass
USER_NAME=user
INVENTORY_PATH=./inventory/hosts
WIREGUARD_IP=192.168.122.243
for PLAYBOOK in dns-master.yml wg.yml nginx-web.yml nginx-proxy.yml prometheus.yml zookeeper.yml kafka.yml
do
    ansible-playbook ./playbooks/$PLAYBOOK -i $INVENTORY_PATH --user $USER_NAME --ask-pass --ask-become-pass --extra-vars "root_dir=$(pwd) wireguardIP=$WIREGUARD_IP"
done