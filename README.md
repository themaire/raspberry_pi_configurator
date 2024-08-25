# raspberry pi ansible role

# STEPS for good results #

## 1 -- Flashing SD card with Raspberry Pi Imager #

<p>Before flashing, please set a custom pi's password, configure wifi (if needed) and activate ssh.<br/>
<br/>
Easy!

## 2 -- Create a ssh key #

<p>On the computer you will use Ansible, create a ssh key for your futur Raspberry's user (nico for me, change it as you like).<br/>
To generate it : ssh-keygen -f ~/.ssh/nico.key<br/>
<br/>
!!! >>> Dont forget to replace the file ./role/raspberry_pi/files/nico.key.pub by <b>"your futur username".key.pub</b> like nico.key.pub.<br/>

After the good execution of the playbook, you will be able to connect via ssh without password.
</p>

## 3 -- Set passwords in the vault file #

<p>Vault's file password in stored 'group_vars/new' folder : foobar. So it takes effect only for the 'new' node group.<br/><br/>
Vault usage :<br>
  
```{r, engine='bash', count_lines}
ansible-vault rekey ./group_vars/new/vault.yml
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


### Supports: #
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

### By default: #
- Updates and upgrades each node.
- Installs log2ram, with 40mb RAM size for log folder.
- Sets gpu_mem to 16mb.
- Disables HDMI.
- Disables IPv6 on wlan0 and eth0

## Role Variables

```yaml
---
# All uncommented lines are default settings

locale: 'fr_FR.UTF-8'
timezone: 'Europe/Paris'

# Ex. 'node' will result in, node0, node1, node2...
#hostname_prefix: 'rpi_'

# Addiontional packages to install
#packages:
- git
- tmux
- vim
- nmon
- neofetch

# Changes SSH port
#ssh_port: 22

# RAM size for log2ram folder in megabytes
log2ram_size: '128'

# GPU memory split in megabytes
gpu_mem: '16' # 16, 64, 128 or 256

# Disable HDMI to preserve power
disable_hdmi: true

# Disable IPv6 on specified interfaces
disable_ipv6_interfaces:
  - wlan0
  - eth0

# Samba configuration
samba_packages:
  - samba-common
  - samba
  - samba-client

samba_services:
  - smbd
#  - nmbd

#samba_netbios_name: monserveur
samba_configuration_dir: /etc/samba
samba_configuration: "{{ samba_configuration_dir }}/smb.conf"
```

## Example Playbook

```yaml
---
- hosts: all
  become: true

  vars_files:
  - config.yml

  roles:
    - raspberry_pi
```

## Credits
Inspired from : 
https://galaxy.ansible.com/zjael/raspberry_pi
( https://github.com/zjael/raspberry_pi )

