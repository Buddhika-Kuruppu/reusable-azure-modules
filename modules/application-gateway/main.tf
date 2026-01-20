resource "azurerm_application_gateway" "main" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku {
    name = var.sku_name
    tier = var.sku_tier
  }

  autoscale_configuration {
    min_capacity = var.min_capacity
    max_capacity = var.max_capacity
  }

  gateway_ip_configuration {
    name      = "${var.name}-gateway-ip-config"
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = "${var.name}-frontend-port"
    port = var.frontend_port
  }

  frontend_ip_configuration {
    name                          = "${var.name}-frontend-ip-config"
    public_ip_address_id          = var.public_ip_address_id
    private_ip_address            = var.private_ip_address
    private_ip_address_allocation = var.private_ip_address != null ? "Static" : null
  }

  backend_address_pool {
    name         = "${var.name}-backend-pool"
    fqdns        = var.backend_fqdns
    ip_addresses = var.backend_ip_addresses
  }

  backend_http_settings {
    name                  = "${var.name}-backend-http-settings"
    cookie_based_affinity = "Disabled"
    port                  = var.backend_port
    protocol              = var.backend_protocol
    request_timeout       = 30
  }

  http_listener {
    name                           = "${var.name}-http-listener"
    frontend_ip_configuration_name = "${var.name}-frontend-ip-config"
    frontend_port_name             = "${var.name}-frontend-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "${var.name}-routing-rule"
    rule_type                  = "Basic"
    http_listener_name         = "${var.name}-http-listener"
    backend_address_pool_name  = "${var.name}-backend-pool"
    backend_http_settings_name = "${var.name}-backend-http-settings"
    priority                   = 100
  }

  tags = var.tags
}
