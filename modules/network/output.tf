output "vnet_id" {
  description = "The ID of the Virtual Network"
  value       = azurerm_virtual_network.vnet.id
}

output "subnet_id" {
  description = "The ID of the subnet"
  value       = azurerm_subnet.subnet.id
}

output "nic_ids" {
  description = "List of Network Interface Card (NIC) IDs"
  value       = [for nic in azurerm_network_interface.nic : nic.id]
}

output "public_ip" {
  description = "Public IP address for the web VM"
  value       = azurerm_public_ip.web_vm_ip.ip_address
}

output "private_ips" {
  description = "List of private IP addresses from NICs"
  value       = [for nic in azurerm_network_interface.nic : nic.private_ip_address]
}