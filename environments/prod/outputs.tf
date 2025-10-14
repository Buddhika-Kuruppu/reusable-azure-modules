output "resource_group_id" {
  description = "The ID of the resource group"
  value       = module.resource_group.id
}

output "resource_group_name" {
  description = "The name of the resource group"
  value       = module.resource_group.name
}

output "virtual_network_id" {
  description = "The ID of the virtual network"
  value       = module.virtual_network.id
}

output "virtual_network_name" {
  description = "The name of the virtual network"
  value       = module.virtual_network.name
}

output "subnet_ids" {
  description = "The IDs of all subnets"
  value       = module.virtual_network.subnet_ids
}
