
**Eksempel på modul-README (modules/vm/README.md):**
```markdown
# VM-modul

Denne modulen oppretter:
- To database-VM-er (MySQL på Ubuntu)
- Én web-VM (Apache2 på Ubuntu)

## Input-variabler

- `location`
- `resource_group_name`
- `admin_username`
- `ssh_public_key`
- `vm_size`
- `nic_ids`
- `public_ip`
- `private_ips`

## Output

- `web_vm_public_ip`
- `db_vm_private_ips`

## Bruk

Kalles fra root-modulen og får NIC-IDs og IP-er fra network-modulen.