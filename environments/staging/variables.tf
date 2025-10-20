variable "location" {
  description = "The Azure region for resources"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "rg-staging-001"
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
  default     = "vnet-staging-001"
}

variable "vnet_address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
  default     = ["10.1.0.0/16"]
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
  default = {
    subnet1 = {
      address_prefixes = ["10.1.1.0/24"]
    }
    subnet2 = {
      address_prefixes = ["10.1.2.0/24"]
    }
  }
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

variable "network_tags" {
  description = "A mapping of tags to assign to network resources"
  type        = map(string)
  default = {
    Environment = "Staging"
    ManagedBy   = "Terraform"
  }
}

variable "infra_tags" {
  description = "A mapping of tags to assign to infrastructure resources"
  type        = map(string)
  default = {
    Environment = "Staging"
    ManagedBy   = "Terraform"
  }
}
