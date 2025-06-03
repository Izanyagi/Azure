output "web_vm_public_ip" {
  description = "Public IP address of the web VM"
  value       = var.public_ip
}

output "db_vm_private_ips" {
  description = "Private IP addresses of the database VMs"
  value       = var.private_ips
}