
# Raspberry Pi Ansible Role

## Steps for a Successful Setup

### 1 — Flash the SD Card with Raspberry Pi Imager

Before flashing, set a custom password for the Pi, configure Wi-Fi (if needed), and enable SSH.

### 2 — Create an SSH Key

On the computer where you will use Ansible, create an SSH key for your future Raspberry Pi user (e.g. `nico`, change as needed):

```bash
ssh-keygen -f ~/.ssh/nico.key
```

**Important:** Replace the file `./roles/raspberry_pi/files/nico.key.pub` with your own public key, named after your future username (e.g. `nico.key.pub`).
After running the playbook, you will be able to connect via SSH without a password.

### 3 — Set Passwords in the Vault File

The vault file is stored in the `group_vars/new` folder (`vault.yml`). It only affects the `new` node group.

Vault usage:

```bash
ansible-vault rekey ./group_vars/new/vault.yml
ansible-vault edit ./group_vars/new/vault.yml
```

It is recommended to declare one admin user first, and no regular users.

### 4 — Adapt the Inventory File

Edit the `inventory.yml` file. Several boards are present as examples.

### 5 — Run the Playbook

1. Connect to your fresh Raspberry Pi OS via SSH and disconnect immediately.
2. (Best option) View or run the file `demo_role_raspberrypi.sh`.
3. Enjoy!

---

## Project Structure

```
raspbian_configurator/
├── inventory.yml
├── play_configrasp.yml
├── roles/
│   └── raspberry_pi/
│       ├── defaults/
│       │   └── main.yml
│       ├── files/
│       ├── handlers/
│       ├── meta/
│       ├── tasks/
│       ├── templates/
│       └── tests/
├── group_vars/
│   └── new/
│       ├── new.yml
│       └── vault.yml
└── README.md
```

---

## Features

- Updates and upgrades each node.
- Installs specified packages (and Log2Ram).
- Creates admin group and users listed in `users_admin`.
- Changes hostnames using prefix and index from inventory.
- Sets GPU memory split.
- Changes timezone and locale.
- Disables HDMI to save power.
- Disables IPv6 on specified interfaces.
- Changes SSH port.
- Disallows SSH root login and empty passwords.
- Disallows SSH password authentication if an SSH key is provided.
- Allows SSH password authentication within an IP range, if specified.

### Defaults

- Updates and upgrades each node.
- Installs Log2Ram with 128MB RAM size for the log folder.
- Sets GPU memory to 16MB.
- Disables HDMI.
- Disables IPv6 on `wlan0` and `eth0`.

---

## Role Variables

```yaml
# All uncommented lines are default settings

locale: 'fr_FR.UTF-8'
timezone: 'Europe/Paris'

# Example: 'node' will result in node0, node1, node2...
#hostname_prefix: 'rpi_'

# Additional packages to install
packages:
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

# Disable HDMI to save power
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
  # - nmbd

#samba_netbios_name: monserveur
samba_configuration_dir: /etc/samba
samba_configuration: "{{ samba_configuration_dir }}/smb.conf"
```

---

## Example Playbook

```yaml
- hosts: all
  become: true

  vars_files:
    - config.yml

  roles:
    - raspberry_pi
```

---

## Credits

Inspired by:
<https://galaxy.ansible.com/zjael/raspberry_pi>
( <https://github.com/zjael/raspberry_pi> )
