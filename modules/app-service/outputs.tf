output "app_service_id" {
  description = "The ID of the App Service"
  value       = var.os_type == "Linux" ? azurerm_linux_web_app.main[0].id : azurerm_windows_web_app.main[0].id
}

output "app_service_name" {
  description = "The name of the App Service"
  value       = var.os_type == "Linux" ? azurerm_linux_web_app.main[0].name : azurerm_windows_web_app.main[0].name
}

output "service_plan_id" {
  description = "The ID of the App Service Plan"
  value       = azurerm_service_plan.main.id
}

output "service_plan_name" {
  description = "The name of the App Service Plan"
  value       = azurerm_service_plan.main.name
}

output "default_hostname" {
  description = "The default hostname of the App Service"
  value       = var.os_type == "Linux" ? azurerm_linux_web_app.main[0].default_hostname : azurerm_windows_web_app.main[0].default_hostname
}

output "outbound_ip_addresses" {
  description = "A comma separated list of outbound IP addresses"
  value       = var.os_type == "Linux" ? azurerm_linux_web_app.main[0].outbound_ip_addresses : azurerm_windows_web_app.main[0].outbound_ip_addresses
}

output "possible_outbound_ip_addresses" {
  description = "A comma separated list of possible outbound IP addresses"
  value       = var.os_type == "Linux" ? azurerm_linux_web_app.main[0].possible_outbound_ip_addresses : azurerm_windows_web_app.main[0].possible_outbound_ip_addresses
}

output "identity" {
  description = "The managed identity block of the App Service"
  value       = var.os_type == "Linux" ? azurerm_linux_web_app.main[0].identity : azurerm_windows_web_app.main[0].identity
}

output "custom_domain_verification_id" {
  description = "The identifier used by App Service to perform domain ownership verification"
  value       = var.os_type == "Linux" ? azurerm_linux_web_app.main[0].custom_domain_verification_id : azurerm_windows_web_app.main[0].custom_domain_verification_id
  sensitive   = true
}
