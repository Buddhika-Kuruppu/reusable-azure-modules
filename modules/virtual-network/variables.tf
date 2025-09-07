variable "name" {
  description = "The name of the virtual network"
  type        = string
}

variable "location" {
  description = "The Azure region where the virtual network should exist"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual network"
  type        = string
}

variable "address_space" {
  description = "The address space that is used the virtual network"
  type        = list(string)
}

variable "subnets" {
  description = "A map of subnet configurations"
  type = map(object({
    address_prefixes         = list(string)
    network_security_group   = optional(string)
    delegations = optional(map(object({
      name    = string
      actions = list(string)
    })))
  }))
  default = {}
}

variable "network_security_groups" {
  description = "A map of network security group configurations"
  type = map(object({
    rules = optional(list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    })))
  }))
  default = {}
}

variable "tags" {
  description = "A mapping of tags to assign to the virtual network and associated resources"
  type        = map(string)
  default     = {}
}