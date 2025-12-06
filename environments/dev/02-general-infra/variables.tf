variable "location" {
  description = "The Azure region for resources"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "The name of the resource group for general infrastructure"
  type        = string
  default     = "rg-dev-infra-001"
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
