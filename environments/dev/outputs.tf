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

output "subnets" {
  description = "Map of subnet information"
  value = {
    for k, v in module.subnets : k => {
      id               = v.id
      name             = v.name
      address_prefixes = v.address_prefixes
    }
  }
}

output "network_security_groups" {
  description = "Map of network security group information"
  value       = module.virtual_network.network_security_groups
}
