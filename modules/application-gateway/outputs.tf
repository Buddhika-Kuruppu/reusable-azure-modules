output "id" {
  description = "The ID of the Application Gateway"
  value       = azurerm_application_gateway.main.id
}

output "name" {
  description = "The name of the Application Gateway"
  value       = azurerm_application_gateway.main.name
}

output "backend_address_pool" {
  description = "A list of backend address pool blocks"
  value       = azurerm_application_gateway.main.backend_address_pool
}

output "backend_http_settings" {
  description = "A list of backend HTTP settings blocks"
  value       = azurerm_application_gateway.main.backend_http_settings
}

output "frontend_ip_configuration" {
  description = "A list of frontend IP configuration blocks"
  value       = azurerm_application_gateway.main.frontend_ip_configuration
}

output "frontend_port" {
  description = "A list of frontend port blocks"
  value       = azurerm_application_gateway.main.frontend_port
}

output "gateway_ip_configuration" {
  description = "A list of gateway IP configuration blocks"
  value       = azurerm_application_gateway.main.gateway_ip_configuration
}

output "http_listener" {
  description = "A list of HTTP listener blocks"
  value       = azurerm_application_gateway.main.http_listener
}

output "private_endpoint_connection" {
  description = "A list of private endpoint connections"
  value       = azurerm_application_gateway.main.private_endpoint_connection
}

output "private_link_configuration" {
  description = "A list of private link configurations"
  value       = azurerm_application_gateway.main.private_link_configuration
}

output "probe" {
  description = "A list of probe blocks"
  value       = azurerm_application_gateway.main.probe
}

output "request_routing_rule" {
  description = "A list of request routing rule blocks"
  value       = azurerm_application_gateway.main.request_routing_rule
}

output "ssl_certificate" {
  description = "A list of SSL certificate blocks"
  value       = azurerm_application_gateway.main.ssl_certificate
  sensitive   = true
}

output "url_path_map" {
  description = "A list of URL path map blocks"
  value       = azurerm_application_gateway.main.url_path_map
}

output "identity" {
  description = "An identity block"
  value       = azurerm_application_gateway.main.identity
}
