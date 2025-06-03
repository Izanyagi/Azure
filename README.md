# Azure Infrastruktur med Terraform

Dette prosjektet setter opp et Azure-miljø med:
- Ett virtuelt nettverk og subnett
- To MySQL-database-VM-er (Ubuntu)
- Én web-VM (Ubuntu med Apache2)
- En intern Azure Load Balancer for database-VM-ene

## Struktur

- **modules/network**: Oppretter Virtual Network, Subnet, NSG, NICs og Public IP.
- **modules/vm**: Oppretter virtuelle maskiner for databaser (MySQL) og web (Apache2).
- **modules/loadbalancer**: Oppretter en intern Azure Load Balancer for database-VM-ene.

## Bruk

1. **Installer Terraform** og logg inn i Azure med `az login`.
2. Legg inn din SSH-nøkkel i `terraform.tfvars` (variabelen `ssh_public_key`).
3. Kjør følgende kommandoer:
   ```sh
   terraform init
   terraform plan
   terraform apply