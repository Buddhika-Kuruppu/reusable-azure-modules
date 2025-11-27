variable "name" {
  description = "The name of the App Service Plan"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where the App Service Plan will be created"
  type        = string
}

variable "os_type" {
  description = "The OS type for the App Service Plan (Linux or Windows)"
  type        = string
  validation {
    condition     = contains(["Linux", "Windows"], var.os_type)
    error_message = "OS type must be either 'Linux' or 'Windows'"
  }
}

variable "sku_name" {
  description = "The SKU name for the App Service Plan (e.g., B1, S1, P1v2, P1v3)"
  type        = string
}

variable "worker_count" {
  description = "The number of workers for the App Service Plan"
  type        = number
  default     = null
}

variable "per_site_scaling_enabled" {
  description = "Should per-site scaling be enabled"
  type        = bool
  default     = false
}

variable "zone_balancing_enabled" {
  description = "Should zone balancing be enabled"
  type        = bool
  default     = false
}

variable "maximum_elastic_worker_count" {
  description = "The maximum number of elastic workers for the App Service Plan"
  type        = number
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
