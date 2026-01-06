variable "location" {
  description = "The Azure region for resources"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "rg-dev-001"
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
  default     = "vnet-dev-001"
}

variable "vnet_address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
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
      address_prefixes       = ["10.0.1.0/24"]
      network_security_group = "contoso-nsg-dev-0"
      delegations = {
        appservice = {
          name    = "Microsoft.Web/serverFarms"
          actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }
      }
    }
    subnet2 = {
      address_prefixes       = ["10.0.2.0/24"]
      network_security_group = "contoso-nsg-dev-1"
    }
    subnet3 = {
      address_prefixes       = ["10.0.3.0/24"]
      network_security_group = "contoso-nsg-dev-2"
    }
    subnet4 = {
      address_prefixes       = ["10.0.4.0/24"]
      network_security_group = "contoso-nsg-dev-3"
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
  default = {
    contoso-nsg-dev-0 = {
      rules = [
        {
          name                       = "Allow-HTTP"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "80"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        },
        {
          name                       = "Allow-HTTPS"
          priority                   = 110
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "443"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
    }
    contoso-nsg-dev-1 = {
      rules = [
        {
          name                       = "Allow-SSH"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "22"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        },
        {
          name                       = "Allow-RDP"
          priority                   = 110
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "3389"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
    }
    contoso-nsg-dev-2 = {
      rules = [
        {
          name                       = "Allow-HTTPS"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "443"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
    }
    contoso-nsg-dev-3 = {
      rules = [
        {
          name                       = "Allow-Custom"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "8080"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
    }
  }
}

variable "network_tags" {
  description = "A mapping of tags to assign to network resources"
  type        = map(string)
  default = {
    Environment  = "Development"
    ManagedBy    = "Terraform"
    Project      = "Contoso-Infrastructure"
    ResourceType = "Network"
  }
}
