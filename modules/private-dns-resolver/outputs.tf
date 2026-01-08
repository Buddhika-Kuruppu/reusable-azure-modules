output "id" {
  description = "The ID of the private DNS resolver"
  value       = azurerm_private_dns_resolver.this.id
}

output "name" {
  description = "The name of the private DNS resolver"
  value       = azurerm_private_dns_resolver.this.name
}

output "inbound_endpoints" {
  description = "Map of inbound endpoints created"
  value = {
    for k, v in azurerm_private_dns_resolver_inbound_endpoint.this : k => {
      id   = v.id
      name = v.name
      ip_configurations = {
        private_ip_address           = v.ip_configurations[0].private_ip_address
        private_ip_allocation_method = v.ip_configurations[0].private_ip_allocation_method
        subnet_id                    = v.ip_configurations[0].subnet_id
      }
    }
  }
}

output "outbound_endpoints" {
  description = "Map of outbound endpoints created"
  value = {
    for k, v in azurerm_private_dns_resolver_outbound_endpoint.this : k => {
      id        = v.id
      name      = v.name
      subnet_id = v.subnet_id
    }
  }
}

output "dns_forwarding_rulesets" {
  description = "Map of DNS forwarding rulesets created"
  value = {
    for k, v in azurerm_private_dns_resolver_dns_forwarding_ruleset.this : k => {
      id   = v.id
      name = v.name
    }
  }
}

output "forwarding_rules" {
  description = "Map of forwarding rules created"
  value = {
    for k, v in azurerm_private_dns_resolver_forwarding_rule.this : k => {
      id          = v.id
      name        = v.name
      domain_name = v.domain_name
      enabled     = v.enabled
    }
  }
}

output "virtual_network_links" {
  description = "Map of virtual network links created"
  value = {
    for k, v in azurerm_private_dns_resolver_virtual_network_link.this : k => {
      id                 = v.id
      name               = v.name
      virtual_network_id = v.virtual_network_id
    }
  }
}
