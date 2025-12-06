# Development Environment - General Infrastructure Stage Configuration

location            = "eastus"
resource_group_name = "rg-dev-infra-001"

infra_tags = {
  Environment  = "Development"
  ManagedBy    = "Terraform"
  Project      = "Azure-Infrastructure"
  ResourceType = "Infrastructure"
  Stage        = "02-General-Infra"
}

# Storage Account Configuration
storage_account_name                    = "stdevaccount001"
storage_account_tier                    = "Standard"
storage_account_replication_type        = "LRS"
storage_account_kind                    = "StorageV2"
storage_account_access_tier             = "Hot"
storage_enable_https_traffic_only       = true
storage_min_tls_version                 = "TLS1_2"
storage_allow_nested_items_to_be_public = false
storage_shared_access_key_enabled       = true
