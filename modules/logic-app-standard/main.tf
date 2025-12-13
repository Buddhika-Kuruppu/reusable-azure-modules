resource "azurerm_logic_app_standard" "main" {
  name                       = var.name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  app_service_plan_id        = var.app_service_plan_id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key

  app_settings                       = var.app_settings
  use_extension_bundle               = var.use_extension_bundle
  bundle_version                     = var.bundle_version
  client_affinity_enabled            = var.client_affinity_enabled
  client_certificate_mode            = var.client_certificate_mode
  enabled                            = var.enabled
  https_only                         = var.https_only
  version                            = var.version
  virtual_network_subnet_id          = var.virtual_network_subnet_id

  dynamic "site_config" {
    for_each = var.site_config != null ? [var.site_config] : []
    content {
      always_on                              = lookup(site_config.value, "always_on", null)
      app_scale_limit                        = lookup(site_config.value, "app_scale_limit", null)
      dotnet_framework_version               = lookup(site_config.value, "dotnet_framework_version", null)
      elastic_instance_minimum               = lookup(site_config.value, "elastic_instance_minimum", null)
      ftps_state                             = lookup(site_config.value, "ftps_state", null)
      health_check_path                      = lookup(site_config.value, "health_check_path", null)
      http2_enabled                          = lookup(site_config.value, "http2_enabled", null)
      linux_fx_version                       = lookup(site_config.value, "linux_fx_version", null)
      min_tls_version                        = lookup(site_config.value, "min_tls_version", null)
      pre_warmed_instance_count              = lookup(site_config.value, "pre_warmed_instance_count", null)
      public_network_access_enabled          = lookup(site_config.value, "public_network_access_enabled", null)
      runtime_scale_monitoring_enabled       = lookup(site_config.value, "runtime_scale_monitoring_enabled", null)
      use_32_bit_worker_process              = lookup(site_config.value, "use_32_bit_worker_process", null)
      vnet_route_all_enabled                 = lookup(site_config.value, "vnet_route_all_enabled", null)
      websockets_enabled                     = lookup(site_config.value, "websockets_enabled", null)

      dynamic "cors" {
        for_each = lookup(site_config.value, "cors", null) != null ? [lookup(site_config.value, "cors")] : []
        content {
          allowed_origins     = cors.value.allowed_origins
          support_credentials = lookup(cors.value, "support_credentials", null)
        }
      }

      dynamic "ip_restriction" {
        for_each = lookup(site_config.value, "ip_restriction", [])
        content {
          ip_address                = lookup(ip_restriction.value, "ip_address", null)
          service_tag               = lookup(ip_restriction.value, "service_tag", null)
          virtual_network_subnet_id = lookup(ip_restriction.value, "virtual_network_subnet_id", null)
          name                      = lookup(ip_restriction.value, "name", null)
          priority                  = lookup(ip_restriction.value, "priority", null)
          action                    = lookup(ip_restriction.value, "action", null)
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
      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }

  tags = var.tags
}
