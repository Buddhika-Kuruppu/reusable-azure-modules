output "id" {
  description = "The ID of the storage queue"
  value       = azurerm_storage_queue.this.id
}

output "name" {
  description = "The name of the storage queue"
  value       = azurerm_storage_queue.this.name
}

output "resource_manager_id" {
  description = "The Resource Manager ID of this Storage Queue"
  value       = azurerm_storage_queue.this.resource_manager_id
}
