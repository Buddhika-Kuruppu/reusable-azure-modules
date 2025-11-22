variable "name" {
  description = "The name of the App Service"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the App Service"
  type        = string
}

variable "location" {
  description = "The Azure region where the App Service should exist"
  type        = string
}

variable "service_plan_name" {
  description = "The name of the App Service Plan"
  type        = string
}

variable "os_type" {
  description = "The operating system type for the App Service Plan (Linux or Windows)"
  type        = string
  default     = "Linux"
  validation {
    condition     = contains(["Linux", "Windows"], var.os_type)
    error_message = "The os_type must be either 'Linux' or 'Windows'."
  }
}

variable "sku_name" {
  description = "The SKU for the App Service Plan (e.g., B1, S1, P1v2, P1v3)"
  type        = string
  default     = "B1"
}

variable "https_only" {
  description = "Should the App Service only be accessible via HTTPS"
  type        = bool
  default     = true
}

variable "enabled" {
  description = "Should the App Service be enabled"
  type        = bool
  default     = true
}

variable "site_config" {
  description = "Site configuration for the App Service"
  type = object({
    always_on           = optional(bool)
    ftps_state          = optional(string)
    http2_enabled       = optional(bool)
    minimum_tls_version = optional(string)
    application_stack = optional(object({
      dotnet_version           = optional(string)
      java_version             = optional(string)
      node_version             = optional(string)
      php_version              = optional(string)
      python_version           = optional(string)
      python                   = optional(bool)
      docker_image_name        = optional(string)
      docker_registry_url      = optional(string)
      current_stack            = optional(string)
      docker_container_name    = optional(string)
      docker_container_registry = optional(string)
    }))
    ip_restrictions = optional(list(object({
      ip_address                = optional(string)
      virtual_network_subnet_id = optional(string)
      action                    = optional(string)
      priority                  = optional(number)
      name                      = optional(string)
    })))
  })
  default = {
    always_on           = true
    ftps_state          = "Disabled"
    http2_enabled       = true
    minimum_tls_version = "1.2"
  }
}

variable "app_settings" {
  description = "A map of key-value pairs for App Settings"
  type        = map(string)
  default     = {}
}

variable "connection_strings" {
  description = "Connection strings for the App Service"
  type = list(object({
    name  = string
    type  = string
    value = string
  }))
  default = null
}

variable "identity" {
  description = "Managed identity configuration for the App Service"
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
}

variable "tags" {
  description = "A mapping of tags to assign to the App Service"
  type        = map(string)
  default     = {}
}
