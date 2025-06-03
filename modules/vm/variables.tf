#variables.tf

variable "location" {
  description = "Azure region for the VMs"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "admin_username" {
  description = "Admin username for VMs"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key content"
  type        = string
}

variable "vm_size" {
  description = "Size of the virtual machines"
  type        = string
}

variable "nic_ids" {
  description = "List of NIC IDs to attach to VMs"
  type        = list(string)
}

variable "public_ip" {
  description = "Public IP address for the web VM"
  type        = string
}

variable "private_ips" {
  description = "List of private IPs for VMs"
  type        = list(string)
}