#!/bin/bash

# Commencer par supprimer la ligne correspondante dans ~/.ssh/knows_hosts
# vim ~/.ssh/known_hosts

# Si ce n'est pas déja fait, créer une clé ssh au nom de l'utilisateur à créer.
# Ensuite, placer la clé publique, par exemple nico.key.pub dans le dossier files du role
# ssh-keygen -f ~/.ssh/nico.key

# Il faut se connecter au moins une fois en SSH afin que la clé publique du
# pi à configurer soit ajouté à notre liste de clés connus par notre client SSH.
# Exemple : 
# nico@macmini ~ % ssh pi@192.168.0.16
# The authenticity of host '192.168.0.16 (192.168.0.16)' can't be established.
# ECDSA key fingerprint is SHA256:ecSJ9ERhxWvrExrdSF1XVudLSLWcbZKMq2f477UBiU8.
# Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
# Warning: Permanently added '192.168.0.16' (ECDSA) to the list of known hosts.

# L'application du playbook Ansible est maintenant possible car toute la magie sera
# injectée par SSH.

ansible-playbook -i inventory.yml -u pi -k --ask-vault-pass play_configrasp.yml

# Il demande le mot de passe SSH de l'utilisateur Pi ainsi que celui du fichier de variables
# crypté qui contient les mots de passe des utilisateurs à créer ^^.
