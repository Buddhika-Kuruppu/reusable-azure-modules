variable "name" {
  description = "The name of the Application Gateway"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Application Gateway"
  type        = string
}

variable "location" {
  description = "The Azure region where the Application Gateway should be created"
  type        = string
}

variable "sku_name" {
  description = "The name of the SKU to use for this Application Gateway. Possible values are Standard_Small, Standard_Medium, Standard_Large, Standard_v2, WAF_Medium, WAF_Large, and WAF_v2"
  type        = string
}

variable "sku_tier" {
  description = "The tier of the SKU to use for this Application Gateway. Possible values are Standard, Standard_v2, WAF and WAF_v2"
  type        = string
}

variable "sku_capacity" {
  description = "The capacity of the SKU to use for this Application Gateway - which must be between 1 and 125"
  type        = number
  default     = null
}

variable "gateway_ip_configuration_name" {
  description = "The name of the gateway IP configuration"
  type        = string
  default     = "gateway-ip-configuration"
}

variable "subnet_id" {
  description = "The ID of the subnet which the Application Gateway should be connected to"
  type        = string
}

variable "frontend_ports" {
  description = "List of frontend ports for the Application Gateway"
  type = list(object({
    name = string
    port = number
  }))
}

variable "frontend_ip_configurations" {
  description = "List of frontend IP configurations for the Application Gateway"
  type = list(object({
    name                          = string
    subnet_id                     = optional(string)
    private_ip_address            = optional(string)
    public_ip_address_id          = optional(string)
    private_ip_address_allocation = optional(string)
  }))
}

variable "backend_address_pools" {
  description = "List of backend address pools for the Application Gateway"
  type = list(object({
    name         = string
    fqdns        = optional(list(string))
    ip_addresses = optional(list(string))
  }))
}

variable "backend_http_settings" {
  description = "List of backend HTTP settings for the Application Gateway"
  type = list(object({
    name                                = string
    cookie_based_affinity               = string
    path                                = optional(string)
    port                                = number
    protocol                            = string
    request_timeout                     = number
    probe_name                          = optional(string)
    host_name                           = optional(string)
    pick_host_name_from_backend_address = optional(bool)
    affinity_cookie_name                = optional(string)
    trusted_root_certificate_names      = optional(list(string))
    authentication_certificate = optional(list(object({
      name = string
    })))
    connection_draining = optional(object({
      enabled           = bool
      drain_timeout_sec = number
    }))
  }))
}

variable "http_listeners" {
  description = "List of HTTP listeners for the Application Gateway"
  type = list(object({
    name                           = string
    frontend_ip_configuration_name = string
    frontend_port_name             = string
    protocol                       = string
    host_name                      = optional(string)
    host_names                     = optional(list(string))
    require_sni                    = optional(bool)
    ssl_certificate_name           = optional(string)
    firewall_policy_id             = optional(string)
    ssl_profile_name               = optional(string)
    custom_error_configuration = optional(list(object({
      status_code           = string
      custom_error_page_url = string
    })))
  }))
}

variable "request_routing_rules" {
  description = "List of request routing rules for the Application Gateway"
  type = list(object({
    name                        = string
    rule_type                   = string
    http_listener_name          = string
    backend_address_pool_name   = optional(string)
    backend_http_settings_name  = optional(string)
    redirect_configuration_name = optional(string)
    rewrite_rule_set_name       = optional(string)
    url_path_map_name           = optional(string)
    priority                    = optional(number)
  }))
}

variable "probes" {
  description = "List of health probes for the Application Gateway"
  type = list(object({
    name                                      = string
    protocol                                  = string
    path                                      = string
    interval                                  = number
    timeout                                   = number
    unhealthy_threshold                       = number
    host                                      = optional(string)
    port                                      = optional(number)
    pick_host_name_from_backend_http_settings = optional(bool)
    minimum_servers                           = optional(number)
    match = optional(object({
      body        = optional(string)
      status_code = list(string)
    }))
  }))
  default = null
}

variable "ssl_certificates" {
  description = "List of SSL certificates for the Application Gateway"
  type = list(object({
    name                = string
    data                = optional(string)
    password            = optional(string)
    key_vault_secret_id = optional(string)
  }))
  default = null
}

variable "trusted_root_certificates" {
  description = "List of trusted root certificates for the Application Gateway"
  type = list(object({
    name                = string
    data                = optional(string)
    key_vault_secret_id = optional(string)
  }))
  default = null
}

variable "authentication_certificates" {
  description = "List of authentication certificates for the Application Gateway"
  type = list(object({
    name = string
    data = string
  }))
  default = null
}

variable "redirect_configurations" {
  description = "List of redirect configurations for the Application Gateway"
  type = list(object({
    name                 = string
    redirect_type        = string
    target_listener_name = optional(string)
    target_url           = optional(string)
    include_path         = optional(bool)
    include_query_string = optional(bool)
  }))
  default = null
}

variable "url_path_maps" {
  description = "List of URL path maps for the Application Gateway"
  type = list(object({
    name                                = string
    default_backend_address_pool_name   = optional(string)
    default_backend_http_settings_name  = optional(string)
    default_redirect_configuration_name = optional(string)
    default_rewrite_rule_set_name       = optional(string)
    path_rules = list(object({
      name                        = string
      paths                       = list(string)
      backend_address_pool_name   = optional(string)
      backend_http_settings_name  = optional(string)
      redirect_configuration_name = optional(string)
      rewrite_rule_set_name       = optional(string)
      firewall_policy_id          = optional(string)
    }))
  }))
  default = null
}

variable "rewrite_rule_sets" {
  description = "List of rewrite rule sets for the Application Gateway"
  type = list(object({
    name = string
    rewrite_rules = list(object({
      name          = string
      rule_sequence = number
      conditions = optional(list(object({
        variable    = string
        pattern     = string
        ignore_case = optional(bool)
        negate      = optional(bool)
      })))
      request_header_configurations = optional(list(object({
        header_name  = string
        header_value = string
      })))
      response_header_configurations = optional(list(object({
        header_name  = string
        header_value = string
      })))
      url = optional(object({
        path         = optional(string)
        query_string = optional(string)
        components   = optional(string)
        reroute      = optional(bool)
      }))
    }))
  }))
  default = null
}

variable "autoscale_configuration" {
  description = "Autoscale configuration for the Application Gateway"
  type = object({
    min_capacity = number
    max_capacity = optional(number)
  })
  default = null
}

variable "waf_configuration" {
  description = "Web Application Firewall configuration for the Application Gateway"
  type = object({
    enabled                  = bool
    firewall_mode            = string
    rule_set_type            = string
    rule_set_version         = string
    file_upload_limit_mb     = optional(number)
    request_body_check       = optional(bool)
    max_request_body_size_kb = optional(number)
    disabled_rule_groups = optional(list(object({
      rule_group_name = string
      rules           = optional(list(number))
    })))
    exclusions = optional(list(object({
      match_variable          = string
      selector_match_operator = optional(string)
      selector                = optional(string)
    })))
  })
  default = null
}

variable "custom_error_configurations" {
  description = "List of custom error configurations for the Application Gateway"
  type = list(object({
    status_code           = string
    custom_error_page_url = string
  }))
  default = null
}

variable "identity" {
  description = "Managed identity configuration for the Application Gateway"
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
}

variable "ssl_policy" {
  description = "SSL policy for the Application Gateway"
  type = object({
    disabled_protocols   = optional(list(string))
    policy_type          = optional(string)
    policy_name          = optional(string)
    cipher_suites        = optional(list(string))
    min_protocol_version = optional(string)
  })
  default = null
}

variable "ssl_profiles" {
  description = "List of SSL profiles for the Application Gateway"
  type = list(object({
    name                             = string
    trusted_client_certificate_names = optional(list(string))
    verify_client_cert_issuer_dn     = optional(bool)
    ssl_policy = optional(object({
      disabled_protocols   = optional(list(string))
      policy_type          = optional(string)
      policy_name          = optional(string)
      cipher_suites        = optional(list(string))
      min_protocol_version = optional(string)
    }))
  }))
  default = null
}

variable "trusted_client_certificates" {
  description = "List of trusted client certificates for the Application Gateway"
  type = list(object({
    name = string
    data = string
  }))
  default = null
}

variable "enable_http2" {
  description = "Whether HTTP2 is enabled on the application gateway resource"
  type        = bool
  default     = null
}

variable "zones" {
  description = "A list of availability zones to use for the Application Gateway"
  type        = list(string)
  default     = null
}

variable "firewall_policy_id" {
  description = "The ID of the Web Application Firewall Policy"
  type        = string
  default     = null
}

variable "force_firewall_policy_association" {
  description = "Whether to force the association with a Web Application Firewall Policy"
  type        = bool
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
