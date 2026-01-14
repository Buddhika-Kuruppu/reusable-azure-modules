resource "azurerm_application_gateway" "main" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku {
    name     = var.sku_name
    tier     = var.sku_tier
    capacity = var.sku_capacity
  }

  gateway_ip_configuration {
    name      = var.gateway_ip_configuration_name
    subnet_id = var.subnet_id
  }

  dynamic "frontend_port" {
    for_each = var.frontend_ports
    content {
      name = frontend_port.value.name
      port = frontend_port.value.port
    }
  }

  dynamic "frontend_ip_configuration" {
    for_each = var.frontend_ip_configurations
    content {
      name                          = frontend_ip_configuration.value.name
      subnet_id                     = lookup(frontend_ip_configuration.value, "subnet_id", null)
      private_ip_address            = lookup(frontend_ip_configuration.value, "private_ip_address", null)
      public_ip_address_id          = lookup(frontend_ip_configuration.value, "public_ip_address_id", null)
      private_ip_address_allocation = lookup(frontend_ip_configuration.value, "private_ip_address_allocation", null)
    }
  }

  dynamic "backend_address_pool" {
    for_each = var.backend_address_pools
    content {
      name         = backend_address_pool.value.name
      fqdns        = lookup(backend_address_pool.value, "fqdns", null)
      ip_addresses = lookup(backend_address_pool.value, "ip_addresses", null)
    }
  }

  dynamic "backend_http_settings" {
    for_each = var.backend_http_settings
    content {
      name                                = backend_http_settings.value.name
      cookie_based_affinity               = backend_http_settings.value.cookie_based_affinity
      path                                = lookup(backend_http_settings.value, "path", null)
      port                                = backend_http_settings.value.port
      protocol                            = backend_http_settings.value.protocol
      request_timeout                     = backend_http_settings.value.request_timeout
      probe_name                          = lookup(backend_http_settings.value, "probe_name", null)
      host_name                           = lookup(backend_http_settings.value, "host_name", null)
      pick_host_name_from_backend_address = lookup(backend_http_settings.value, "pick_host_name_from_backend_address", false)
      affinity_cookie_name                = lookup(backend_http_settings.value, "affinity_cookie_name", null)
      trusted_root_certificate_names      = lookup(backend_http_settings.value, "trusted_root_certificate_names", null)

      dynamic "authentication_certificate" {
        for_each = lookup(backend_http_settings.value, "authentication_certificate", null) != null ? backend_http_settings.value.authentication_certificate : []
        content {
          name = authentication_certificate.value.name
        }
      }

      dynamic "connection_draining" {
        for_each = lookup(backend_http_settings.value, "connection_draining", null) != null ? [backend_http_settings.value.connection_draining] : []
        content {
          enabled           = connection_draining.value.enabled
          drain_timeout_sec = connection_draining.value.drain_timeout_sec
        }
      }
    }
  }

  dynamic "http_listener" {
    for_each = var.http_listeners
    content {
      name                           = http_listener.value.name
      frontend_ip_configuration_name = http_listener.value.frontend_ip_configuration_name
      frontend_port_name             = http_listener.value.frontend_port_name
      protocol                       = http_listener.value.protocol
      host_name                      = lookup(http_listener.value, "host_name", null)
      host_names                     = lookup(http_listener.value, "host_names", null)
      require_sni                    = lookup(http_listener.value, "require_sni", null)
      ssl_certificate_name           = lookup(http_listener.value, "ssl_certificate_name", null)
      firewall_policy_id             = lookup(http_listener.value, "firewall_policy_id", null)
      ssl_profile_name               = lookup(http_listener.value, "ssl_profile_name", null)

      dynamic "custom_error_configuration" {
        for_each = lookup(http_listener.value, "custom_error_configuration", null) != null ? http_listener.value.custom_error_configuration : []
        content {
          status_code           = custom_error_configuration.value.status_code
          custom_error_page_url = custom_error_configuration.value.custom_error_page_url
        }
      }
    }
  }

  dynamic "request_routing_rule" {
    for_each = var.request_routing_rules
    content {
      name                        = request_routing_rule.value.name
      rule_type                   = request_routing_rule.value.rule_type
      http_listener_name          = request_routing_rule.value.http_listener_name
      backend_address_pool_name   = lookup(request_routing_rule.value, "backend_address_pool_name", null)
      backend_http_settings_name  = lookup(request_routing_rule.value, "backend_http_settings_name", null)
      redirect_configuration_name = lookup(request_routing_rule.value, "redirect_configuration_name", null)
      rewrite_rule_set_name       = lookup(request_routing_rule.value, "rewrite_rule_set_name", null)
      url_path_map_name           = lookup(request_routing_rule.value, "url_path_map_name", null)
      priority                    = lookup(request_routing_rule.value, "priority", null)
    }
  }

  dynamic "probe" {
    for_each = var.probes != null ? var.probes : []
    content {
      name                                      = probe.value.name
      protocol                                  = probe.value.protocol
      path                                      = probe.value.path
      interval                                  = probe.value.interval
      timeout                                   = probe.value.timeout
      unhealthy_threshold                       = probe.value.unhealthy_threshold
      host                                      = lookup(probe.value, "host", null)
      port                                      = lookup(probe.value, "port", null)
      pick_host_name_from_backend_http_settings = lookup(probe.value, "pick_host_name_from_backend_http_settings", false)
      minimum_servers                           = lookup(probe.value, "minimum_servers", null)

      dynamic "match" {
        for_each = lookup(probe.value, "match", null) != null ? [probe.value.match] : []
        content {
          body        = lookup(match.value, "body", null)
          status_code = match.value.status_code
        }
      }
    }
  }

  dynamic "ssl_certificate" {
    for_each = var.ssl_certificates != null ? var.ssl_certificates : []
    content {
      name                = ssl_certificate.value.name
      data                = lookup(ssl_certificate.value, "data", null)
      password            = lookup(ssl_certificate.value, "password", null)
      key_vault_secret_id = lookup(ssl_certificate.value, "key_vault_secret_id", null)
    }
  }

  dynamic "trusted_root_certificate" {
    for_each = var.trusted_root_certificates != null ? var.trusted_root_certificates : []
    content {
      name                = trusted_root_certificate.value.name
      data                = lookup(trusted_root_certificate.value, "data", null)
      key_vault_secret_id = lookup(trusted_root_certificate.value, "key_vault_secret_id", null)
    }
  }

  dynamic "authentication_certificate" {
    for_each = var.authentication_certificates != null ? var.authentication_certificates : []
    content {
      name = authentication_certificate.value.name
      data = authentication_certificate.value.data
    }
  }

  dynamic "redirect_configuration" {
    for_each = var.redirect_configurations != null ? var.redirect_configurations : []
    content {
      name                 = redirect_configuration.value.name
      redirect_type        = redirect_configuration.value.redirect_type
      target_listener_name = lookup(redirect_configuration.value, "target_listener_name", null)
      target_url           = lookup(redirect_configuration.value, "target_url", null)
      include_path         = lookup(redirect_configuration.value, "include_path", false)
      include_query_string = lookup(redirect_configuration.value, "include_query_string", false)
    }
  }

  dynamic "url_path_map" {
    for_each = var.url_path_maps != null ? var.url_path_maps : []
    content {
      name                                = url_path_map.value.name
      default_backend_address_pool_name   = lookup(url_path_map.value, "default_backend_address_pool_name", null)
      default_backend_http_settings_name  = lookup(url_path_map.value, "default_backend_http_settings_name", null)
      default_redirect_configuration_name = lookup(url_path_map.value, "default_redirect_configuration_name", null)
      default_rewrite_rule_set_name       = lookup(url_path_map.value, "default_rewrite_rule_set_name", null)

      dynamic "path_rule" {
        for_each = url_path_map.value.path_rules
        content {
          name                        = path_rule.value.name
          paths                       = path_rule.value.paths
          backend_address_pool_name   = lookup(path_rule.value, "backend_address_pool_name", null)
          backend_http_settings_name  = lookup(path_rule.value, "backend_http_settings_name", null)
          redirect_configuration_name = lookup(path_rule.value, "redirect_configuration_name", null)
          rewrite_rule_set_name       = lookup(path_rule.value, "rewrite_rule_set_name", null)
          firewall_policy_id          = lookup(path_rule.value, "firewall_policy_id", null)
        }
      }
    }
  }

  dynamic "rewrite_rule_set" {
    for_each = var.rewrite_rule_sets != null ? var.rewrite_rule_sets : []
    content {
      name = rewrite_rule_set.value.name

      dynamic "rewrite_rule" {
        for_each = rewrite_rule_set.value.rewrite_rules
        content {
          name          = rewrite_rule.value.name
          rule_sequence = rewrite_rule.value.rule_sequence

          dynamic "condition" {
            for_each = lookup(rewrite_rule.value, "conditions", null) != null ? rewrite_rule.value.conditions : []
            content {
              variable    = condition.value.variable
              pattern     = condition.value.pattern
              ignore_case = lookup(condition.value, "ignore_case", false)
              negate      = lookup(condition.value, "negate", false)
            }
          }

          dynamic "request_header_configuration" {
            for_each = lookup(rewrite_rule.value, "request_header_configurations", null) != null ? rewrite_rule.value.request_header_configurations : []
            content {
              header_name  = request_header_configuration.value.header_name
              header_value = request_header_configuration.value.header_value
            }
          }

          dynamic "response_header_configuration" {
            for_each = lookup(rewrite_rule.value, "response_header_configurations", null) != null ? rewrite_rule.value.response_header_configurations : []
            content {
              header_name  = response_header_configuration.value.header_name
              header_value = response_header_configuration.value.header_value
            }
          }

          dynamic "url" {
            for_each = lookup(rewrite_rule.value, "url", null) != null ? [rewrite_rule.value.url] : []
            content {
              path         = lookup(url.value, "path", null)
              query_string = lookup(url.value, "query_string", null)
              components   = lookup(url.value, "components", null)
              reroute      = lookup(url.value, "reroute", null)
            }
          }
        }
      }
    }
  }

  dynamic "autoscale_configuration" {
    for_each = var.autoscale_configuration != null ? [var.autoscale_configuration] : []
    content {
      min_capacity = autoscale_configuration.value.min_capacity
      max_capacity = lookup(autoscale_configuration.value, "max_capacity", null)
    }
  }

  dynamic "waf_configuration" {
    for_each = var.waf_configuration != null ? [var.waf_configuration] : []
    content {
      enabled                  = waf_configuration.value.enabled
      firewall_mode            = waf_configuration.value.firewall_mode
      rule_set_type            = waf_configuration.value.rule_set_type
      rule_set_version         = waf_configuration.value.rule_set_version
      file_upload_limit_mb     = lookup(waf_configuration.value, "file_upload_limit_mb", 100)
      request_body_check       = lookup(waf_configuration.value, "request_body_check", true)
      max_request_body_size_kb = lookup(waf_configuration.value, "max_request_body_size_kb", 128)

      dynamic "disabled_rule_group" {
        for_each = lookup(waf_configuration.value, "disabled_rule_groups", null) != null ? waf_configuration.value.disabled_rule_groups : []
        content {
          rule_group_name = disabled_rule_group.value.rule_group_name
          rules           = lookup(disabled_rule_group.value, "rules", null)
        }
      }

      dynamic "exclusion" {
        for_each = lookup(waf_configuration.value, "exclusions", null) != null ? waf_configuration.value.exclusions : []
        content {
          match_variable          = exclusion.value.match_variable
          selector_match_operator = lookup(exclusion.value, "selector_match_operator", null)
          selector                = lookup(exclusion.value, "selector", null)
        }
      }
    }
  }

  dynamic "custom_error_configuration" {
    for_each = var.custom_error_configurations != null ? var.custom_error_configurations : []
    content {
      status_code           = custom_error_configuration.value.status_code
      custom_error_page_url = custom_error_configuration.value.custom_error_page_url
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }

  dynamic "ssl_policy" {
    for_each = var.ssl_policy != null ? [var.ssl_policy] : []
    content {
      disabled_protocols   = lookup(ssl_policy.value, "disabled_protocols", null)
      policy_type          = lookup(ssl_policy.value, "policy_type", null)
      policy_name          = lookup(ssl_policy.value, "policy_name", null)
      cipher_suites        = lookup(ssl_policy.value, "cipher_suites", null)
      min_protocol_version = lookup(ssl_policy.value, "min_protocol_version", null)
    }
  }

  dynamic "ssl_profile" {
    for_each = var.ssl_profiles != null ? var.ssl_profiles : []
    content {
      name                             = ssl_profile.value.name
      trusted_client_certificate_names = lookup(ssl_profile.value, "trusted_client_certificate_names", null)
      verify_client_cert_issuer_dn     = lookup(ssl_profile.value, "verify_client_cert_issuer_dn", false)

      dynamic "ssl_policy" {
        for_each = lookup(ssl_profile.value, "ssl_policy", null) != null ? [ssl_profile.value.ssl_policy] : []
        content {
          disabled_protocols   = lookup(ssl_policy.value, "disabled_protocols", null)
          policy_type          = lookup(ssl_policy.value, "policy_type", null)
          policy_name          = lookup(ssl_policy.value, "policy_name", null)
          cipher_suites        = lookup(ssl_policy.value, "cipher_suites", null)
          min_protocol_version = lookup(ssl_policy.value, "min_protocol_version", null)
        }
      }
    }
  }

  dynamic "trusted_client_certificate" {
    for_each = var.trusted_client_certificates != null ? var.trusted_client_certificates : []
    content {
      name = trusted_client_certificate.value.name
      data = trusted_client_certificate.value.data
    }
  }

  enable_http2        = var.enable_http2
  zones               = var.zones
  firewall_policy_id  = var.firewall_policy_id
  force_firewall_policy_association = var.force_firewall_policy_association

  tags = var.tags
}
