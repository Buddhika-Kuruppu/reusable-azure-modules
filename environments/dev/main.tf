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
