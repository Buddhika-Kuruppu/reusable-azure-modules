output "id" {
  description = "The ID of the storage table"
  value       = azurerm_storage_table.this.id
}

output "name" {
  description = "The name of the storage table"
  value       = azurerm_storage_table.this.name
}

output "resource_manager_id" {
  description = "The Resource Manager ID of this Storage Table"
  value       = azurerm_storage_table.this.resource_manager_id
}
