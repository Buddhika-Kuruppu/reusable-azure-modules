variable "name" {
  description = "The name of the API Management service"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the API Management service"
  type        = string
}

variable "location" {
  description = "The Azure region where the API Management service should exist"
  type        = string
}

variable "publisher_name" {
  description = "The name of the publisher/company"
  type        = string
}

variable "publisher_email" {
  description = "The email address of the publisher/company"
  type        = string
}

variable "sku_name" {
  description = "The SKU of the API Management service (e.g., Developer_1, Basic_1, Standard_1, Premium_1)"
  type        = string
  default     = "Developer_1"
}

variable "notification_sender_email" {
  description = "The email address from which the notification will be sent"
  type        = string
  default     = null
}

variable "gateway_disabled" {
  description = "Whether the gateway is disabled for the API Management service"
  type        = bool
  default     = false
}

variable "min_api_version" {
  description = "The minimum API version that the API Management service will accept"
  type        = string
  default     = null
}

variable "zones" {
  description = "Specifies a list of availability zones in which this API Management service should be located"
  type        = list(string)
  default     = null
}

variable "public_ip_address_id" {
  description = "The ID of a standard SKU IPv4 Public IP address"
  type        = string
  default     = null
}

variable "identity" {
  description = "Managed identity configuration for the API Management service"
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
}

variable "hostname_configuration" {
  description = "Custom hostname configuration for the API Management service"
  type = object({
    management = optional(list(object({
      host_name                    = string
      key_vault_id                 = optional(string)
      certificate                  = optional(string)
      certificate_password         = optional(string)
      negotiate_client_certificate = optional(bool)
    })))
    portal = optional(list(object({
      host_name                    = string
      key_vault_id                 = optional(string)
      certificate                  = optional(string)
      certificate_password         = optional(string)
      negotiate_client_certificate = optional(bool)
    })))
    developer_portal = optional(list(object({
      host_name                    = string
      key_vault_id                 = optional(string)
      certificate                  = optional(string)
      certificate_password         = optional(string)
      negotiate_client_certificate = optional(bool)
    })))
    proxy = optional(list(object({
      host_name                    = string
      default_ssl_binding          = optional(bool)
      key_vault_id                 = optional(string)
      certificate                  = optional(string)
      certificate_password         = optional(string)
      negotiate_client_certificate = optional(bool)
    })))
    scm = optional(list(object({
      host_name                    = string
      key_vault_id                 = optional(string)
      certificate                  = optional(string)
      certificate_password         = optional(string)
      negotiate_client_certificate = optional(bool)
    })))
  })
  default = null
}

variable "additional_locations" {
  description = "Additional datacenter locations for the API Management service"
  type = list(object({
    location             = string
    capacity             = optional(number)
    zones                = optional(list(string))
    public_ip_address_id = optional(string)
    virtual_network_configuration = optional(object({
      subnet_id = string
    }))
  }))
  default = null
}

variable "virtual_network_configuration" {
  description = "Virtual network configuration for the API Management service"
  type = object({
    subnet_id = string
  })
  default = null
}

variable "certificates" {
  description = "List of certificates for the API Management service"
  type = list(object({
    encoded_certificate  = string
    certificate_password = optional(string)
    store_name           = string
  }))
  default = null
}

variable "protocols" {
  description = "Protocol settings for the API Management service"
  type = object({
    enable_http2 = optional(bool)
  })
  default = null
}

variable "security" {
  description = "Security settings for the API Management service"
  type = object({
    enable_backend_ssl30                                = optional(bool)
    enable_backend_tls10                                = optional(bool)
    enable_backend_tls11                                = optional(bool)
    enable_frontend_ssl30                               = optional(bool)
    enable_frontend_tls10                               = optional(bool)
    enable_frontend_tls11                               = optional(bool)
    tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = optional(bool)
    tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = optional(bool)
    tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled   = optional(bool)
    tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled   = optional(bool)
    tls_rsa_with_aes128_cbc_sha256_ciphers_enabled      = optional(bool)
    tls_rsa_with_aes128_cbc_sha_ciphers_enabled         = optional(bool)
    tls_rsa_with_aes128_gcm_sha256_ciphers_enabled      = optional(bool)
    tls_rsa_with_aes256_cbc_sha256_ciphers_enabled      = optional(bool)
    tls_rsa_with_aes256_cbc_sha_ciphers_enabled         = optional(bool)
    triple_des_ciphers_enabled                          = optional(bool)
  })
  default = null
}

variable "sign_in" {
  description = "Sign-in configuration for the developer portal"
  type = object({
    enabled = bool
  })
  default = null
}

variable "sign_up" {
  description = "Sign-up configuration for the developer portal"
  type = object({
    enabled = bool
    terms_of_service = optional(object({
      consent_required = bool
      enabled          = bool
      text             = optional(string)
    }))
  })
  default = null
}

variable "policy" {
  description = "Global policy configuration for the API Management service"
  type = object({
    xml_content = optional(string)
    xml_link    = optional(string)
  })
  default = null
}

variable "tags" {
  description = "A mapping of tags to assign to the API Management service"
  type        = map(string)
  default     = {}
}
