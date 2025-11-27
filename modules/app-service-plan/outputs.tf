output "id" {
  description = "The ID of the App Service Plan"
  value       = azurerm_service_plan.main.id
}

output "name" {
  description = "The name of the App Service Plan"
  value       = azurerm_service_plan.main.name
}

output "kind" {
  description = "The kind of the App Service Plan"
  value       = azurerm_service_plan.main.kind
}

output "reserved" {
  description = "Whether this is a reserved App Service Plan (Linux)"
  value       = azurerm_service_plan.main.reserved
}
