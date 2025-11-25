output "id" {
  description = "The ID of the API Management service"
  value       = azurerm_api_management.main.id
}

output "name" {
  description = "The name of the API Management service"
  value       = azurerm_api_management.main.name
}

output "gateway_url" {
  description = "The URL of the Gateway for the API Management service"
  value       = azurerm_api_management.main.gateway_url
}

output "gateway_regional_url" {
  description = "The region URL for the Gateway of the API Management service"
  value       = azurerm_api_management.main.gateway_regional_url
}

output "management_api_url" {
  description = "The URL for the Management API associated with this API Management service"
  value       = azurerm_api_management.main.management_api_url
}

output "portal_url" {
  description = "The URL for the Publisher Portal associated with this API Management service"
  value       = azurerm_api_management.main.portal_url
}

output "developer_portal_url" {
  description = "The URL for the Developer Portal associated with this API Management service"
  value       = azurerm_api_management.main.developer_portal_url
}

output "public_ip_addresses" {
  description = "The public IP addresses of the API Management service"
  value       = azurerm_api_management.main.public_ip_addresses
}

output "private_ip_addresses" {
  description = "The private IP addresses of the API Management service"
  value       = azurerm_api_management.main.private_ip_addresses
}

output "scm_url" {
  description = "The URL for the SCM (Source Code Management) endpoint associated with this API Management service"
  value       = azurerm_api_management.main.scm_url
}

output "identity" {
  description = "The managed identity block of the API Management service"
  value       = azurerm_api_management.main.identity
}

output "tenant_access" {
  description = "The tenant access information of the API Management service"
  value       = azurerm_api_management.main.tenant_access
  sensitive   = true
}

output "policy_id" {
  description = "The ID of the API Management Policy"
  value       = try(azurerm_api_management_policy.main[0].id, null)
}
