# Network-modul

Denne modulen oppretter:
- Virtual Network og Subnet
- Network Security Group (NSG) med SSH, HTTP og MySQL-regler
- Public IP for web-VM
- Tre NICs

## Input-variabler

- `vnet_name`
- `vnet_address_space`
- `subnet_names`
- `subnet_address_prefixes`
- `location`
- `resource_group_name`

## Output

- `vnet_id`
- `subnet_id`
- `nic_ids`
- `public_ip`
- `private_ips`