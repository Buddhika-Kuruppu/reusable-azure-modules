variable "name" {
  description = "The name of the private DNS zone (e.g., privatelink.blob.core.windows.net)"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "virtual_network_links" {
  description = "Map of virtual network links to create"
  type = map(object({
    name                 = string
    virtual_network_id   = string
    registration_enabled = optional(bool, false)
  }))
  default = {}
}
