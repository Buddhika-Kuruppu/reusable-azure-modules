output "resource_group_name" {
  description = "The name of the resource group"
  value       = module.resource_group.name
}

output "resource_group_id" {
  description = "The ID of the resource group"
  value       = module.resource_group.id
}

output "vnet_id" {
  description = "The ID of the virtual network"
  value       = module.virtual_network.id
}

output "vnet_name" {
  description = "The name of the virtual network"
  value       = module.virtual_network.name
}

output "subnet_ids" {
  description = "Map of subnet names to their IDs"
  value       = { for k, v in module.subnets : k => v.id }
}

output "subnet_names" {
  description = "Map of subnet keys to their names"
  value       = { for k, v in module.subnets : k => v.name }
}

output "nsg_ids" {
  description = "Map of NSG names to their IDs"
  value       = { for k, v in module.network_security_groups : k => v.id }
}

output "nsg_names" {
  description = "Map of NSG keys to their names"
  value       = { for k, v in module.network_security_groups : k => v.name }
}
