resource "azurerm_api_management" "main" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email
  sku_name            = var.sku_name

  notification_sender_email = var.notification_sender_email
  gateway_disabled          = var.gateway_disabled
  min_api_version           = var.min_api_version
  zones                     = var.zones
  public_ip_address_id      = var.public_ip_address_id

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }

  dynamic "hostname_configuration" {
    for_each = var.hostname_configuration != null ? [var.hostname_configuration] : []
    content {
      dynamic "management" {
        for_each = lookup(hostname_configuration.value, "management", null) != null ? hostname_configuration.value.management : []
        content {
          host_name                       = management.value.host_name
          key_vault_id                    = lookup(management.value, "key_vault_id", null)
          certificate                     = lookup(management.value, "certificate", null)
          certificate_password            = lookup(management.value, "certificate_password", null)
          negotiate_client_certificate    = lookup(management.value, "negotiate_client_certificate", false)
        }
      }

      dynamic "portal" {
        for_each = lookup(hostname_configuration.value, "portal", null) != null ? hostname_configuration.value.portal : []
        content {
          host_name                       = portal.value.host_name
          key_vault_id                    = lookup(portal.value, "key_vault_id", null)
          certificate                     = lookup(portal.value, "certificate", null)
          certificate_password            = lookup(portal.value, "certificate_password", null)
          negotiate_client_certificate    = lookup(portal.value, "negotiate_client_certificate", false)
        }
      }

      dynamic "developer_portal" {
        for_each = lookup(hostname_configuration.value, "developer_portal", null) != null ? hostname_configuration.value.developer_portal : []
        content {
          host_name                       = developer_portal.value.host_name
          key_vault_id                    = lookup(developer_portal.value, "key_vault_id", null)
          certificate                     = lookup(developer_portal.value, "certificate", null)
          certificate_password            = lookup(developer_portal.value, "certificate_password", null)
          negotiate_client_certificate    = lookup(developer_portal.value, "negotiate_client_certificate", false)
        }
      }

      dynamic "proxy" {
        for_each = lookup(hostname_configuration.value, "proxy", null) != null ? hostname_configuration.value.proxy : []
        content {
          host_name                       = proxy.value.host_name
          default_ssl_binding             = lookup(proxy.value, "default_ssl_binding", false)
          key_vault_id                    = lookup(proxy.value, "key_vault_id", null)
          certificate                     = lookup(proxy.value, "certificate", null)
          certificate_password            = lookup(proxy.value, "certificate_password", null)
          negotiate_client_certificate    = lookup(proxy.value, "negotiate_client_certificate", false)
        }
      }

      dynamic "scm" {
        for_each = lookup(hostname_configuration.value, "scm", null) != null ? hostname_configuration.value.scm : []
        content {
          host_name                       = scm.value.host_name
          key_vault_id                    = lookup(scm.value, "key_vault_id", null)
          certificate                     = lookup(scm.value, "certificate", null)
          certificate_password            = lookup(scm.value, "certificate_password", null)
          negotiate_client_certificate    = lookup(scm.value, "negotiate_client_certificate", false)
        }
      }
    }
  }

  dynamic "additional_location" {
    for_each = var.additional_locations != null ? var.additional_locations : []
    content {
      location             = additional_location.value.location
      capacity             = lookup(additional_location.value, "capacity", null)
      zones                = lookup(additional_location.value, "zones", null)
      public_ip_address_id = lookup(additional_location.value, "public_ip_address_id", null)

      dynamic "virtual_network_configuration" {
        for_each = lookup(additional_location.value, "virtual_network_configuration", null) != null ? [additional_location.value.virtual_network_configuration] : []
        content {
          subnet_id = virtual_network_configuration.value.subnet_id
        }
      }
    }
  }

  dynamic "virtual_network_configuration" {
    for_each = var.virtual_network_configuration != null ? [var.virtual_network_configuration] : []
    content {
      subnet_id = virtual_network_configuration.value.subnet_id
    }
  }

  dynamic "certificate" {
    for_each = var.certificates != null ? var.certificates : []
    content {
      encoded_certificate  = certificate.value.encoded_certificate
      certificate_password = lookup(certificate.value, "certificate_password", null)
      store_name           = certificate.value.store_name
    }
  }

  dynamic "protocols" {
    for_each = var.protocols != null ? [var.protocols] : []
    content {
      enable_http2 = lookup(protocols.value, "enable_http2", false)
    }
  }

  dynamic "security" {
    for_each = var.security != null ? [var.security] : []
    content {
      enable_backend_ssl30                                = lookup(security.value, "enable_backend_ssl30", false)
      enable_backend_tls10                                = lookup(security.value, "enable_backend_tls10", false)
      enable_backend_tls11                                = lookup(security.value, "enable_backend_tls11", false)
      enable_frontend_ssl30                               = lookup(security.value, "enable_frontend_ssl30", false)
      enable_frontend_tls10                               = lookup(security.value, "enable_frontend_tls10", false)
      enable_frontend_tls11                               = lookup(security.value, "enable_frontend_tls11", false)
      tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = lookup(security.value, "tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled", false)
      tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = lookup(security.value, "tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled", false)
      tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled   = lookup(security.value, "tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled", false)
      tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled   = lookup(security.value, "tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled", false)
      tls_rsa_with_aes128_cbc_sha256_ciphers_enabled      = lookup(security.value, "tls_rsa_with_aes128_cbc_sha256_ciphers_enabled", false)
      tls_rsa_with_aes128_cbc_sha_ciphers_enabled         = lookup(security.value, "tls_rsa_with_aes128_cbc_sha_ciphers_enabled", false)
      tls_rsa_with_aes128_gcm_sha256_ciphers_enabled      = lookup(security.value, "tls_rsa_with_aes128_gcm_sha256_ciphers_enabled", false)
      tls_rsa_with_aes256_cbc_sha256_ciphers_enabled      = lookup(security.value, "tls_rsa_with_aes256_cbc_sha256_ciphers_enabled", false)
      tls_rsa_with_aes256_cbc_sha_ciphers_enabled         = lookup(security.value, "tls_rsa_with_aes256_cbc_sha_ciphers_enabled", false)
      triple_des_ciphers_enabled                          = lookup(security.value, "triple_des_ciphers_enabled", false)
    }
  }

  dynamic "sign_in" {
    for_each = var.sign_in != null ? [var.sign_in] : []
    content {
      enabled = sign_in.value.enabled
    }
  }

  dynamic "sign_up" {
    for_each = var.sign_up != null ? [var.sign_up] : []
    content {
      enabled = sign_up.value.enabled

      dynamic "terms_of_service" {
        for_each = lookup(sign_up.value, "terms_of_service", null) != null ? [sign_up.value.terms_of_service] : []
        content {
          consent_required = terms_of_service.value.consent_required
          enabled          = terms_of_service.value.enabled
          text             = lookup(terms_of_service.value, "text", null)
        }
      }
    }
  }

  tags = var.tags
}

resource "azurerm_api_management_policy" "main" {
  count               = var.policy != null ? 1 : 0
  api_management_id   = azurerm_api_management.main.id
  xml_content         = lookup(var.policy, "xml_content", null)
  xml_link            = lookup(var.policy, "xml_link", null)
}
