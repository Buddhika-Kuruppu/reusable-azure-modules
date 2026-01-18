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
    cookie_based_affinity               = optional(string, "Disabled")
    path                                = optional(string)
    port                                = number
    protocol                            = string
    request_timeout                     = optional(number, 30)
    probe_name                          = optional(string)
    pick_host_name_from_backend_address = optional(bool, false)
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
    ssl_certificate_name           = optional(string)
  }))
}

variable "request_routing_rules" {
  description = "List of request routing rules for the Application Gateway"
  type = list(object({
    name                       = string
    rule_type                  = string
    http_listener_name         = string
    backend_address_pool_name  = string
    backend_http_settings_name = string
    priority                   = number
  }))
}

variable "probes" {
  description = "List of health probes for the Application Gateway"
  type = list(object({
    name                                      = string
    protocol                                  = string
    path                                      = string
    interval                                  = optional(number, 30)
    timeout                                   = optional(number, 30)
    unhealthy_threshold                       = optional(number, 3)
    pick_host_name_from_backend_http_settings = optional(bool, true)
    match = optional(object({
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

variable "autoscale_configuration" {
  description = "Autoscale configuration for the Application Gateway"
  type = object({
    min_capacity = number
    max_capacity = optional(number)
  })
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

variable "enable_http2" {
  description = "Whether HTTP2 is enabled on the application gateway resource"
  type        = bool
  default     = true
}

variable "zones" {
  description = "A list of availability zones to use for the Application Gateway"
  type        = list(string)
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
