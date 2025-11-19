# Resource Group
module "resource_group" {
  source = "../../modules/resource-group"

  name     = var.resource_group_name
  location = var.location
  tags     = var.infra_tags
}

# Network Security Groups
module "network_security_groups" {
  source = "../../modules/network-security-group"

  for_each = var.network_security_groups

  name                = each.key
  location            = var.location
  resource_group_name = module.resource_group.name
  security_rules      = lookup(each.value, "rules", null)
  tags                = var.network_tags

  depends_on = [module.resource_group]
}

# Virtual Network
module "virtual_network" {
  source = "../../modules/virtual-network"

  name                = var.vnet_name
  location            = var.location
  resource_group_name = module.resource_group.name
  address_space       = var.vnet_address_space
  tags                = var.network_tags

  depends_on = [module.resource_group]
}

# Subnets
module "subnets" {
  source = "../../modules/subnet"

  for_each = var.subnets

  name                       = each.key
  resource_group_name        = module.resource_group.name
  virtual_network_name       = module.virtual_network.name
  address_prefixes           = each.value.address_prefixes
  delegations                = lookup(each.value, "delegations", null)
  network_security_group_id  = lookup(each.value, "network_security_group", null) != null ? module.network_security_groups[each.value.network_security_group].id : null

  depends_on = [module.virtual_network, module.network_security_groups]
}

# Storage Account
module "storage_account" {
  source = "../../modules/storage-account"

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
