output "id" {
  description = "The ID of the network security group"
  value       = azurerm_network_security_group.main.id
}

output "name" {
  description = "The name of the network security group"
  value       = azurerm_network_security_group.main.name
}

output "location" {
  description = "The location of the network security group"
  value       = azurerm_network_security_group.main.location
}
