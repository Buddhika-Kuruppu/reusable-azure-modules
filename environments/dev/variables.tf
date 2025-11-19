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
      network_security_group = "sec-ae-nsg-dev-0"
      delegations = {
        appservice = {
          name    = "Microsoft.Web/serverFarms"
          actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }
      }
    }
    subnet2 = {
      address_prefixes       = ["10.0.2.0/24"]
      network_security_group = "sec-ae-nsg-dev-1"
    }
    subnet3 = {
      address_prefixes       = ["10.0.3.0/24"]
      network_security_group = "sec-ae-nsg-dev-2"
    }
    subnet4 = {
      address_prefixes       = ["10.0.4.0/24"]
      network_security_group = "sec-ae-nsg-dev-3"
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
    sec-ae-nsg-dev-0 = {
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
    sec-ae-nsg-dev-1 = {
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
    sec-ae-nsg-dev-2 = {
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
    sec-ae-nsg-dev-3 = {
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
    Project      = "Azure-Infrastructure"
    ResourceType = "Network"
  }
}

variable "infra_tags" {
  description = "A mapping of tags to assign to infrastructure resources"
  type        = map(string)
  default = {
    Environment  = "Development"
    ManagedBy    = "Terraform"
    Project      = "Azure-Infrastructure"
    ResourceType = "Infrastructure"
  }
}

# Storage Account Variables
variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "storage_account_tier" {
  description = "Defines the Tier to use for this storage account (Standard or Premium)"
  type        = string
  default     = "Standard"
}

variable "storage_account_replication_type" {
  description = "Defines the type of replication to use for this storage account"
  type        = string
  default     = "LRS"
}

variable "storage_account_kind" {
  description = "Defines the Kind of account"
  type        = string
  default     = "StorageV2"
}

variable "storage_account_access_tier" {
  description = "Defines the access tier for BlobStorage and StorageV2 accounts"
  type        = string
  default     = "Hot"
}

variable "storage_enable_https_traffic_only" {
  description = "Boolean flag which forces HTTPS if enabled"
  type        = bool
  default     = true
}

variable "storage_min_tls_version" {
  description = "The minimum supported TLS version for the storage account"
  type        = string
  default     = "TLS1_2"
}

variable "storage_allow_nested_items_to_be_public" {
  description = "Allow or disallow nested items within this Account to opt into being public"
  type        = bool
  default     = false
}

variable "storage_shared_access_key_enabled" {
  description = "Indicates whether the storage account permits requests to be authorized with the account access key"
  type        = bool
  default     = true
}

variable "storage_blob_properties" {
  description = "Blob properties configuration"
  type = object({
    versioning_enabled       = optional(bool)
    change_feed_enabled      = optional(bool)
    last_access_time_enabled = optional(bool)
    delete_retention_policy = optional(object({
      days = optional(number)
    }))
    container_delete_retention_policy = optional(object({
      days = optional(number)
    }))
  })
  default = null
}

variable "storage_network_rules" {
  description = "Network rules configuration for the storage account"
  type = object({
    default_action             = optional(string)
    bypass                     = optional(list(string))
    ip_rules                   = optional(list(string))
    virtual_network_subnet_ids = optional(list(string))
  })
  default = null
}
