variable "name" {
  description = "The name of the Logic App Standard"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where the Logic App Standard will be created"
  type        = string
}

variable "app_service_plan_id" {
  description = "The ID of the App Service Plan within which to create this Logic App"
  type        = string
}

variable "storage_account_name" {
  description = "The backend storage account name which will be used by this Logic App"
  type        = string
}

variable "storage_account_access_key" {
  description = "The access key which will be used to access the backend storage account for the Logic App"
  type        = string
  sensitive   = true
}

variable "app_settings" {
  description = "A map of key-value pairs for App Settings and custom values"
  type        = map(string)
  default     = {}
}

variable "use_extension_bundle" {
  description = "Should the logic app use the bundled extension package"
  type        = bool
  default     = true
}

variable "bundle_version" {
  description = "If use_extension_bundle is true, specifies the version range of the extension bundle to use"
  type        = string
  default     = "[1.*, 2.0.0)"
}

variable "client_affinity_enabled" {
  description = "Should the Logic App send session affinity cookies"
  type        = bool
  default     = false
}

variable "client_certificate_mode" {
  description = "The mode of the Logic App's client certificates requirement for incoming requests"
  type        = string
  default     = null
  validation {
    condition     = var.client_certificate_mode == null || contains(["Required", "Optional", "OptionalInteractiveUser"], var.client_certificate_mode)
    error_message = "Client certificate mode must be either 'Required', 'Optional', or 'OptionalInteractiveUser'"
  }
}

variable "enabled" {
  description = "Is the Logic App enabled"
  type        = bool
  default     = true
}

variable "https_only" {
  description = "Can the Logic App only be accessed via HTTPS"
  type        = bool
  default     = true
}

variable "version" {
  description = "The runtime version associated with the Logic App"
  type        = string
  default     = "~4"
}

variable "virtual_network_subnet_id" {
  description = "The subnet id which will be used by this Logic App for regional virtual network integration"
  type        = string
  default     = null
}

variable "site_config" {
  description = "A site_config block for the Logic App"
  type        = any
  default     = null
}

variable "connection_strings" {
  description = "Connection strings for the Logic App"
  type = list(object({
    name  = string
    type  = string
    value = string
  }))
  default = []
}

variable "identity" {
  description = "An identity block for the Logic App"
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
