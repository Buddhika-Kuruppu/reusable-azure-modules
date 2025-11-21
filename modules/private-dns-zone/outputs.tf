output "id" {
  description = "The ID of the private DNS zone"
  value       = azurerm_private_dns_zone.this.id
}

output "name" {
  description = "The name of the private DNS zone"
  value       = azurerm_private_dns_zone.this.name
}

output "number_of_record_sets" {
  description = "The current number of record sets in this Private DNS zone"
  value       = azurerm_private_dns_zone.this.number_of_record_sets
}

output "max_number_of_record_sets" {
  description = "The maximum number of record sets that can be created in this Private DNS zone"
  value       = azurerm_private_dns_zone.this.max_number_of_record_sets
}

output "max_number_of_virtual_network_links" {
  description = "The maximum number of virtual networks that can be linked to this Private DNS zone"
  value       = azurerm_private_dns_zone.this.max_number_of_virtual_network_links
}

output "max_number_of_virtual_network_links_with_registration" {
  description = "The maximum number of virtual networks that can be linked to this Private DNS zone with registration enabled"
  value       = azurerm_private_dns_zone.this.max_number_of_virtual_network_links_with_registration
}

output "virtual_network_links" {
  description = "Map of virtual network links created"
  value = {
    for k, v in azurerm_private_dns_zone_virtual_network_link.this : k => {
      id                   = v.id
      name                 = v.name
      virtual_network_id   = v.virtual_network_id
      registration_enabled = v.registration_enabled
    }
  }
}
