resource "azurerm_virtual_network_peering" "source_to_destination" {
  name                         = var.peering_name_source_to_destination
  resource_group_name          = var.source_vnet_resource_group_name
  virtual_network_name         = var.source_vnet_name
  remote_virtual_network_id    = var.destination_vnet_id
  allow_virtual_network_access = var.allow_virtual_network_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic
  allow_gateway_transit        = var.allow_gateway_transit
  use_remote_gateways          = var.use_remote_gateways
}

resource "azurerm_virtual_network_peering" "destination_to_source" {
  count = var.create_reverse_peering ? 1 : 0

  name                         = var.peering_name_destination_to_source
  resource_group_name          = var.destination_vnet_resource_group_name
  virtual_network_name         = var.destination_vnet_name
  remote_virtual_network_id    = var.source_vnet_id
  allow_virtual_network_access = var.allow_virtual_network_access_reverse
  allow_forwarded_traffic      = var.allow_forwarded_traffic_reverse
  allow_gateway_transit        = var.allow_gateway_transit_reverse
  use_remote_gateways          = var.use_remote_gateways_reverse
}
