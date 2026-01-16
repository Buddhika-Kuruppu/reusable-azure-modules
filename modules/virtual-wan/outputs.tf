output "id" {
  description = "The ID of the virtual WAN"
  value       = azurerm_virtual_wan.main.id
}

output "name" {
  description = "The name of the virtual WAN"
  value       = azurerm_virtual_wan.main.name
}

output "location" {
  description = "The location of the virtual WAN"
  value       = azurerm_virtual_wan.main.location
}

output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_virtual_wan.main.resource_group_name
}

output "type" {
  description = "The type of the virtual WAN"
  value       = azurerm_virtual_wan.main.type
}

output "tags" {
  description = "The tags assigned to the virtual WAN"
  value       = azurerm_virtual_wan.main.tags
}
