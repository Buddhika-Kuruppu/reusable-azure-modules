output "id" {
  description = "The ID of the storage container"
  value       = azurerm_storage_container.this.id
}

output "name" {
  description = "The name of the storage container"
  value       = azurerm_storage_container.this.name
}

output "has_immutability_policy" {
  description = "Is there an Immutability Policy configured on this Storage Container?"
  value       = azurerm_storage_container.this.has_immutability_policy
}

output "has_legal_hold" {
  description = "Is there a Legal Hold configured on this Storage Container?"
  value       = azurerm_storage_container.this.has_legal_hold
}

output "resource_manager_id" {
  description = "The Resource Manager ID of this Storage Container"
  value       = azurerm_storage_container.this.resource_manager_id
}
