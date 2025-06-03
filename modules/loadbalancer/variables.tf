#variables.tf

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}

variable "backend_pool_ips" {
  description = "List of backend DB VM private IPs"
  type        = list(string)
}

variable "vnet_id" {
  description = "Virtual Network ID for backend addresses"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the frontend IP configuration"
  type        = string
}
