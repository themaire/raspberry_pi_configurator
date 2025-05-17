# raspberry pi ansible role

# STEPS for good results #

## 1 -- Flashing SD card with Raspberry Pi Imager #

<p>Before flashing, please set a custom pi's password, configure wifi (if needed) and activate ssh.<br/>
<br/>
Easy!

## 2 -- Create a ssh key #

<p>On the computer you will use Ansible, create a ssh key for your futur Raspberry's user (nico for me, change it as you like).

To generate it : ssh-keygen -f ~/.ssh/nico.key

!!! >>> Dont forget to replace the file ./roles/raspberry_pi/files/nico.key.pub by <b>"your futur username".key.pub</b> like nico.key.pub.

After the good execution of the playbook, you will be able to connect via ssh without password.
</p>

## 3 -- Set passwords in the vault file #

<p>The vault's file password stored in the 'group_vars/new' folder is : foobar. So the values are only takes effect for the 'new' inventory node group.

Vault usage :
  
```{r, engine='bash', count_lines}
# Change password
ansible-vault rekey ./group_vars/new/vault.yml
3 Edit the vault file
ansible-vault edit ./group_vars/new/vault.yml
```

</p>
<p>
I recommand you to declare first one admin user and no normal users.
</p>

## 4 -- Adapt the iventory file #

<p>Edit the list_piansible.yml inventory file. A couple of boards are presents in the exemple.
</p>

## 5 -- Run the playbook #

<p>1 : Connect to your fresh new Raspberry Pi OS via ssh and disconnect it imediatly.</p>
<p>2 : See (best option) or run the file demo_role_raspberrypi.sh</p>
<p>3 : Enjoy.</p>

### Supports #

- Update and Upgrade each node.
- Install specified packages (and Log2Ram).
- Create admin group and user listed in users_admin variable list.
- Change hostnames specified by prefix and index from inventory file.
- Change GPU memory split.
- Change timezone.
- Change locale.
- Install specified packages.
- Disable HDMI to preserve power.
- Disable IPv6 of specified interfaces.

- ##Change SSH Port.
- ##Disallow SSH root login and empty passwords.
- ##Disallow SSH password authentication, if SSH key is provided.
- ##Allows SSH password authentication, within ip range, if specified.

### By default #

- Updates and upgrades each node.
- Installs log2ram, with 40mb RAM size for log folder.
- Sets gpu_mem to 16mb.
- Disables HDMI.
- Disables IPv6 on wlan0 and eth0

## Role Variables

All the role's variables are in the roles/raspberry_pi/defaults/main.yml file. A array is present to set if you need ton apply some tasks withe a simple true/false settings.

## Example Playbook

This is the playbook who use the role. You can see the vars array of 3 tasks familly you can turn on/off.

```yaml
- name: Configure some new group of one Raspberry Pi

  # Hostname or group name from the inventory file
  hosts: new
  
  # hosts: new # if you want to run the playbook on all hosts in the inventory, use 'all' instead of 'new'
  # hosts: un nom de machine ou un groupe de machines

  become: true
  gather_facts: true

  vars:
    do_mandatory: true
    do_optional: true
    do_experimental: false

  roles:
    - raspberry_pi
```

## Credits

Inspired from :
<https://galaxy.ansible.com/zjael/raspberry_pi>
( <https://github.com/zjael/raspberry_pi> )
