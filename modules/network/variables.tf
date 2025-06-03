#variables.tf


variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "West Europe"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
}

variable "subnet_names" {
  description = "List of subnet names"
  type        = list(string)
}

variable "subnet_address_prefixes" {
  description = "List of subnet address prefixes"
  type        = list(string)
}