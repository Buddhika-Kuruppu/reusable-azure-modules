output "id" {
  description = "The ID of the subnet"
  value       = azurerm_subnet.main.id
}

output "name" {
  description = "The name of the subnet"
  value       = azurerm_subnet.main.name
}

output "address_prefixes" {
  description = "The address prefixes of the subnet"
  value       = azurerm_subnet.main.address_prefixes
}
