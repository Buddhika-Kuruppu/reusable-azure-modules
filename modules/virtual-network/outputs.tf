output "id" {
  description = "The ID of the virtual network"
  value       = azurerm_virtual_network.main.id
}

output "name" {
  description = "The name of the virtual network"
  value       = azurerm_virtual_network.main.name
}

output "location" {
  description = "The location of the virtual network"
  value       = azurerm_virtual_network.main.location
}

output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_virtual_network.main.resource_group_name
}

output "address_space" {
  description = "The address space of the virtual network"
  value       = azurerm_virtual_network.main.address_space
}

output "network_security_groups" {
  description = "A map of network security group information"
  value = {
    for k, v in azurerm_network_security_group.nsg : k => {
      id   = v.id
      name = v.name
    }
  }
}

output "tags" {
  description = "The tags assigned to the virtual network"
  value       = azurerm_virtual_network.main.tags
}