resource "azurerm_service_plan" "main" {
  name                = var.service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.os_type
  sku_name            = var.sku_name

  tags = var.tags
}

resource "azurerm_linux_web_app" "main" {
  count               = var.os_type == "Linux" ? 1 : 0
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.main.id

  https_only = var.https_only
  enabled    = var.enabled

  site_config {
    always_on         = var.site_config.always_on
    ftps_state        = var.site_config.ftps_state
    http2_enabled     = var.site_config.http2_enabled
    minimum_tls_version = var.site_config.minimum_tls_version

    dynamic "application_stack" {
      for_each = var.site_config.application_stack != null ? [var.site_config.application_stack] : []
      content {
        dotnet_version      = lookup(application_stack.value, "dotnet_version", null)
        java_version        = lookup(application_stack.value, "java_version", null)
        node_version        = lookup(application_stack.value, "node_version", null)
        php_version         = lookup(application_stack.value, "php_version", null)
        python_version      = lookup(application_stack.value, "python_version", null)
        docker_image_name   = lookup(application_stack.value, "docker_image_name", null)
        docker_registry_url = lookup(application_stack.value, "docker_registry_url", null)
      }
    }

    dynamic "ip_restriction" {
      for_each = var.site_config.ip_restrictions != null ? var.site_config.ip_restrictions : []
      content {
        ip_address                = lookup(ip_restriction.value, "ip_address", null)
        virtual_network_subnet_id = lookup(ip_restriction.value, "virtual_network_subnet_id", null)
        action                    = lookup(ip_restriction.value, "action", "Allow")
        priority                  = lookup(ip_restriction.value, "priority", 100)
        name                      = lookup(ip_restriction.value, "name", null)
      }
    }
  }

  app_settings = var.app_settings

  dynamic "connection_string" {
    for_each = var.connection_strings != null ? var.connection_strings : []
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

resource "azurerm_windows_web_app" "main" {
  count               = var.os_type == "Windows" ? 1 : 0
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.main.id

  https_only = var.https_only
  enabled    = var.enabled

  site_config {
    always_on         = var.site_config.always_on
    ftps_state        = var.site_config.ftps_state
    http2_enabled     = var.site_config.http2_enabled
    minimum_tls_version = var.site_config.minimum_tls_version

    dynamic "application_stack" {
      for_each = var.site_config.application_stack != null ? [var.site_config.application_stack] : []
      content {
        dotnet_version              = lookup(application_stack.value, "dotnet_version", null)
        java_version                = lookup(application_stack.value, "java_version", null)
        node_version                = lookup(application_stack.value, "node_version", null)
        php_version                 = lookup(application_stack.value, "php_version", null)
        python                      = lookup(application_stack.value, "python", null)
        current_stack               = lookup(application_stack.value, "current_stack", null)
        docker_container_name       = lookup(application_stack.value, "docker_container_name", null)
        docker_container_registry   = lookup(application_stack.value, "docker_container_registry", null)
      }
    }

    dynamic "ip_restriction" {
      for_each = var.site_config.ip_restrictions != null ? var.site_config.ip_restrictions : []
      content {
        ip_address                = lookup(ip_restriction.value, "ip_address", null)
        virtual_network_subnet_id = lookup(ip_restriction.value, "virtual_network_subnet_id", null)
        action                    = lookup(ip_restriction.value, "action", "Allow")
        priority                  = lookup(ip_restriction.value, "priority", 100)
        name                      = lookup(ip_restriction.value, "name", null)
      }
    }
  }

  app_settings = var.app_settings

  dynamic "connection_string" {
    for_each = var.connection_strings != null ? var.connection_strings : []
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
