output "id" {
  description = "The ID of the App Service Environment v3"
  value       = azurerm_app_service_environment_v3.main.id
}

output "name" {
  description = "The name of the App Service Environment v3"
  value       = azurerm_app_service_environment_v3.main.name
}

output "location" {
  description = "The Azure region where the App Service Environment v3 is located"
  value       = azurerm_app_service_environment_v3.main.location
}

output "dns_suffix" {
  description = "The DNS suffix for the App Service Environment v3"
  value       = azurerm_app_service_environment_v3.main.dns_suffix
}

output "external_inbound_ip_addresses" {
  description = "The external inbound IP addresses of the App Service Environment v3"
  value       = azurerm_app_service_environment_v3.main.external_inbound_ip_addresses
}

output "internal_inbound_ip_addresses" {
  description = "The internal inbound IP addresses of the App Service Environment v3"
  value       = azurerm_app_service_environment_v3.main.internal_inbound_ip_addresses
}

output "linux_outbound_ip_addresses" {
  description = "The Linux outbound IP addresses of the App Service Environment v3"
  value       = azurerm_app_service_environment_v3.main.linux_outbound_ip_addresses
}

output "windows_outbound_ip_addresses" {
  description = "The Windows outbound IP addresses of the App Service Environment v3"
  value       = azurerm_app_service_environment_v3.main.windows_outbound_ip_addresses
}
