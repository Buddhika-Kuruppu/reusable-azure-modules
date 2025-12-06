# Resource Group for General Infrastructure
module "resource_group" {
  source = "../../../modules/resource-group"

  name     = var.resource_group_name
  location = var.location
  tags     = var.infra_tags
}

# Storage Account
module "storage_account" {
  source = "../../../modules/storage-account"

  name                     = var.storage_account_name
  resource_group_name      = module.resource_group.name
  location                 = var.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
  account_kind             = var.storage_account_kind
  access_tier              = var.storage_account_access_tier

  enable_https_traffic_only       = var.storage_enable_https_traffic_only
  min_tls_version                 = var.storage_min_tls_version
  allow_nested_items_to_be_public = var.storage_allow_nested_items_to_be_public
  shared_access_key_enabled       = var.storage_shared_access_key_enabled

  blob_properties = var.storage_blob_properties
  network_rules   = var.storage_network_rules

  tags = var.infra_tags

  depends_on = [module.resource_group]
}
