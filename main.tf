terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# ---------------------
# Global Variables
# ---------------------
variable "location" {
  description = "Azure region"
  type        = string
  default     = "westeurope"
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
  default     = "Azure-terraform"
}

variable "admin_username" {
  description = "Admin username for VMs"
  type        = string
  default     = "fagskole-admin"
}

variable "ssh_public_key" {
  description = "SSH public key contents"
  type        = string
}

variable "vm_size" {
  description = "VM size"
  type        = string
  default     = "Standard_B1s"
}

# ---------------------
# Create Resource Group First
# ---------------------
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

# ---------------------
# Module: Network
# ---------------------
module "network" {
  source                  = "./modules/network"
  vnet_name               = "linux-vm-vnet"
  vnet_address_space      = ["192.0.0.0/16"]
  subnet_names            = ["linux-vm-subnet"]
  subnet_address_prefixes = ["192.0.1.0/24"]
  location                = var.location
  resource_group_name     = azurerm_resource_group.main.name
}

# ---------------------
# Module: VMs
# ---------------------
module "vms" {
  source              = "./modules/vm"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  admin_username      = var.admin_username
  ssh_public_key      = var.ssh_public_key
  vm_size             = var.vm_size

  # From network outputs
  nic_ids     = module.network.nic_ids
  public_ip   = module.network.public_ip
  private_ips = module.network.private_ips
}

# ---------------------
# Module: Load Balancer
# ---------------------
module "loadbalancer" {
  source              = "./modules/loadbalancer"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name

  vnet_id   = module.network.vnet_id
  subnet_id = module.network.subnet_id

  backend_pool_ips = [
    module.vms.db_vm_private_ips[0],
    module.vms.db_vm_private_ips[1]
  ]
}


# ---------------------
# Outputs
# ---------------------
output "web_vm_public_ip" {
  description = "Public IP of the web VM"
  value       = module.vms.web_vm_public_ip
}

output "db_vm_private_ips" {
  description = "Private IPs of database VMs"
  value       = module.vms.db_vm_private_ips
}