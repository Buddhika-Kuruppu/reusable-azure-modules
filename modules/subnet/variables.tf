variable "name" {
  description = "The name of the subnet"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the subnet"
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network to which to attach the subnet"
  type        = string
}

variable "address_prefixes" {
  description = "The address prefixes to use for the subnet"
  type        = list(string)
}

variable "delegations" {
  description = "A map of subnet delegations"
  type = map(object({
    name    = string
    actions = list(string)
  }))
  default = null
}

variable "network_security_group_id" {
  description = "The ID of the Network Security Group to associate with the subnet"
  type        = string
  default     = null
}
