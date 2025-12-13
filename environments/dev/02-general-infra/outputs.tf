output "resource_group_name" {
  description = "The name of the infrastructure resource group"
  value       = module.resource_group.name
}

output "resource_group_id" {
  description = "The ID of the infrastructure resource group"
  value       = module.resource_group.id
}

output "storage_account_id" {
  description = "The ID of the storage account"
  value       = module.storage_account.id
}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = module.storage_account.name
}

output "storage_account_primary_blob_endpoint" {
  description = "The primary blob endpoint of the storage account"
  value       = module.storage_account.primary_blob_endpoint
}

output "storage_account_primary_connection_string" {
  description = "The primary connection string for the storage account"
  value       = module.storage_account.primary_connection_string
  sensitive   = true
}

# Output from networking stage (for reference in applications stage)
output "networking_vnet_id" {
  description = "The VNet ID from networking stage"
  value       = data.terraform_remote_state.networking.outputs.vnet_id
}

output "networking_subnet_ids" {
  description = "The subnet IDs from networking stage"
  value       = data.terraform_remote_state.networking.outputs.subnet_ids
}
