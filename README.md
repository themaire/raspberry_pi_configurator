# raspberry pi ansible role

# STEPS for good results #

## Create a ssh key #

<p>Where the computer you use Ansible, create a ssh key for your futur Raspberry's user (nico for me).<br/>
To generate it : ssh-keygen -f ~/.ssh/nico.key<br/>
<br/>
Dont forget to replace the file ./role/raspberry_pi/files/foobar.key.pub with YOUR_OWN_USERNAME.key.pub
by "your futur username".key.pub like nico.key.pub.<br/>

After the good execution of the playbook, you will be able to connect via ssh without password.
</p>

## Set passwords in the vault file #

<p>Vault's file password in stored 'group_vars/new' folder : foobar. So it takes effect only for the 'new' node group.<br/><br/>
Vault usage :<br>
  
```{r, engine='bash', count_lines}
foo@bar:~$ ansible-vault rekey ./group_vars/new/vault.yml<br>
foo@bar:~$ ansible-vault edit ./group_vars/new/vault.yml
```
</p>

## Run the playbook #

<p>1 : Connect to your fresh new Raspberry Pi OS via ssh and disconnect imediatly.</p>
<p>2 : See or run the file demo_role_raspberrypi.sh</p>
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

