output "id" {
  description = "The ID of the Logic App Standard"
  value       = azurerm_logic_app_standard.main.id
}

output "name" {
  description = "The name of the Logic App Standard"
  value       = azurerm_logic_app_standard.main.name
}

output "default_hostname" {
  description = "The default hostname of the Logic App Standard"
  value       = azurerm_logic_app_standard.main.default_hostname
}

output "outbound_ip_addresses" {
  description = "A comma separated list of outbound IP addresses"
  value       = azurerm_logic_app_standard.main.outbound_ip_addresses
}

output "possible_outbound_ip_addresses" {
  description = "A comma separated list of possible outbound IP addresses"
  value       = azurerm_logic_app_standard.main.possible_outbound_ip_addresses
}

output "identity" {
  description = "An identity block, which contains the Managed Service Identity information for this Logic App"
  value       = azurerm_logic_app_standard.main.identity
}

output "kind" {
  description = "The kind of the Logic App Standard"
  value       = azurerm_logic_app_standard.main.kind
}

output "custom_domain_verification_id" {
  description = "The identifier used by App Service to perform domain ownership verification via DNS TXT record"
  value       = azurerm_logic_app_standard.main.custom_domain_verification_id
}
