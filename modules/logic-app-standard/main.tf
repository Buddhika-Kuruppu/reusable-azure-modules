resource "azurerm_logic_app_standard" "main" {
  name                       = var.name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  app_service_plan_id        = var.app_service_plan_id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key

  app_settings              = var.app_settings
  https_only                = var.https_only
  virtual_network_subnet_id = var.virtual_network_subnet_id

  dynamic "site_config" {
    for_each = var.site_config != null ? [var.site_config] : []
    content {
      always_on                     = try(site_config.value.always_on, null)
      min_tls_version               = try(site_config.value.min_tls_version, null)
      public_network_access_enabled = try(site_config.value.public_network_access_enabled, null)
      vnet_route_all_enabled        = try(site_config.value.vnet_route_all_enabled, null)

      dynamic "ip_restriction" {
        for_each = try(site_config.value.ip_restriction, [])
        content {
          ip_address                = try(ip_restriction.value.ip_address, null)
          service_tag               = try(ip_restriction.value.service_tag, null)
          virtual_network_subnet_id = try(ip_restriction.value.virtual_network_subnet_id, null)
          name                      = try(ip_restriction.value.name, null)
          priority                  = try(ip_restriction.value.priority, null)
          action                    = try(ip_restriction.value.action, null)
        }
      }
    }
  }

  dynamic "connection_string" {
    for_each = var.connection_strings
    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = try(identity.value.identity_ids, null)
    }
  }

  tags = var.tags
}
