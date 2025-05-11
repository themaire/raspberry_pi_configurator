#!/bin/bash

## Create and maintain users for Raspberry

ansible-playbook -i inventory.yml -u pi -k --ask-vault-pass play_configrasp.yml
# ansible-playbook -i inventory.yml -k --ask-vault-pass play_configrasp.yml
# Ré executer le role mais cette fois ci pour supprimer le compte PI