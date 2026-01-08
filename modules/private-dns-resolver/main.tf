resource "azurerm_private_dns_resolver" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  virtual_network_id  = var.virtual_network_id
  tags                = var.tags
}

resource "azurerm_private_dns_resolver_inbound_endpoint" "this" {
  for_each = var.inbound_endpoints

  name                    = each.value.name
  private_dns_resolver_id = azurerm_private_dns_resolver.this.id
  location                = var.location
  tags                    = var.tags

  ip_configurations {
    private_ip_allocation_method = each.value.private_ip_allocation_method
    subnet_id                    = each.value.subnet_id
    private_ip_address           = each.value.private_ip_address
  }
}

resource "azurerm_private_dns_resolver_outbound_endpoint" "this" {
  for_each = var.outbound_endpoints

  name                    = each.value.name
  private_dns_resolver_id = azurerm_private_dns_resolver.this.id
  location                = var.location
  subnet_id               = each.value.subnet_id
  tags                    = var.tags
}

resource "azurerm_private_dns_resolver_dns_forwarding_ruleset" "this" {
  for_each = var.dns_forwarding_rulesets

  name                                       = each.value.name
  resource_group_name                        = var.resource_group_name
  location                                   = var.location
  private_dns_resolver_outbound_endpoint_ids = [for endpoint_key in each.value.outbound_endpoint_keys : azurerm_private_dns_resolver_outbound_endpoint.this[endpoint_key].id]
  tags                                       = var.tags
}

resource "azurerm_private_dns_resolver_forwarding_rule" "this" {
  for_each = var.forwarding_rules

  name                      = each.value.name
  dns_forwarding_ruleset_id = azurerm_private_dns_resolver_dns_forwarding_ruleset.this[each.value.ruleset_key].id
  domain_name               = each.value.domain_name
  enabled                   = each.value.enabled

  dynamic "target_dns_servers" {
    for_each = each.value.target_dns_servers
    content {
      ip_address = target_dns_servers.value.ip_address
      port       = target_dns_servers.value.port
    }
  }
}

resource "azurerm_private_dns_resolver_virtual_network_link" "this" {
  for_each = var.virtual_network_links

  name                      = each.value.name
  dns_forwarding_ruleset_id = azurerm_private_dns_resolver_dns_forwarding_ruleset.this[each.value.ruleset_key].id
  virtual_network_id        = each.value.virtual_network_id
}
