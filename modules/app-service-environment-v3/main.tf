resource "azurerm_app_service_environment_v3" "main" {
  name                         = var.name
  resource_group_name          = var.resource_group_name
  subnet_id                    = var.subnet_id
  internal_load_balancing_mode = var.internal_load_balancing_mode
  zone_redundant               = var.zone_redundant
  dedicated_host_count         = var.dedicated_host_count
  allow_new_private_endpoint_connections = var.allow_new_private_endpoint_connections
  remote_debugging_enabled     = var.remote_debugging_enabled

  dynamic "cluster_setting" {
    for_each = var.cluster_settings
    content {
      name  = cluster_setting.value.name
      value = cluster_setting.value.value
    }
  }

  tags = var.tags
}
