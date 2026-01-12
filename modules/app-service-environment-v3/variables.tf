variable "name" {
  description = "The name of the App Service Environment v3"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet for the App Service Environment v3"
  type        = string
}

variable "internal_load_balancing_mode" {
  description = "The Internal Load Balancing Mode. Possible values are None, Web, Publishing, and Web,Publishing"
  type        = string
  default     = "Web,Publishing"
  validation {
    condition     = contains(["None", "Web", "Publishing", "Web,Publishing"], var.internal_load_balancing_mode)
    error_message = "Internal load balancing mode must be one of: None, Web, Publishing, Web,Publishing"
  }
}

variable "zone_redundant" {
  description = "Should the App Service Environment be zone redundant"
  type        = bool
  default     = false
}

variable "dedicated_host_count" {
  description = "The number of dedicated hosts for the App Service Environment"
  type        = number
  default     = null
}

variable "allow_new_private_endpoint_connections" {
  description = "Should new private endpoint connections be allowed"
  type        = bool
  default     = true
}

variable "remote_debugging_enabled" {
  description = "Should remote debugging be enabled"
  type        = bool
  default     = false
}

variable "cluster_settings" {
  description = "List of cluster settings for the App Service Environment"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
