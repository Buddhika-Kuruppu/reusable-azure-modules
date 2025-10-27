resource "azurerm_subnet" "main" {
  name                 = var.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefixes

  dynamic "delegation" {
    for_each = var.delegations != null ? var.delegations : {}

    content {
      name = delegation.key

      service_delegation {
        name    = delegation.value.name
        actions = delegation.value.actions
      }
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "main" {
  count = var.network_security_group_id != null ? 1 : 0

  subnet_id                 = azurerm_subnet.main.id
  network_security_group_id = var.network_security_group_id
}
