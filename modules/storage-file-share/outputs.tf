output "id" {
  description = "The ID of the file share"
  value       = azurerm_storage_share.this.id
}

output "name" {
  description = "The name of the file share"
  value       = azurerm_storage_share.this.name
}

output "resource_manager_id" {
  description = "The Resource Manager ID of this File Share"
  value       = azurerm_storage_share.this.resource_manager_id
}

output "url" {
  description = "The URL of the File Share"
  value       = azurerm_storage_share.this.url
}
