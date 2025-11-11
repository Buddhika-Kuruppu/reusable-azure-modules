variable "name" {
  description = "The name of the network security group"
  type        = string
}

variable "location" {
  description = "The Azure location where the network security group should be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the network security group"
  type        = string
}

variable "security_rules" {
  description = "A list of security rules to apply to the network security group"
  type = list(object({
    name                         = string
    priority                     = number
    direction                    = string
    access                       = string
    protocol                     = string
    source_port_range            = optional(string)
    source_port_ranges           = optional(list(string))
    destination_port_range       = optional(string)
    destination_port_ranges      = optional(list(string))
    source_address_prefix        = optional(string)
    source_address_prefixes      = optional(list(string))
    destination_address_prefix   = optional(string)
    destination_address_prefixes = optional(list(string))
    description                  = optional(string)
  }))
  default = null
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
