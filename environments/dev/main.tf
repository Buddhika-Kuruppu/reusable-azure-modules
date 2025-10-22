# Resource Group
module "resource_group" {
  source = "../../modules/resource-group"

  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Virtual Network
module "virtual_network" {
  source = "../../modules/virtual-network"

  name                     = var.vnet_name
  location                 = var.location
  resource_group_name      = module.resource_group.name
  address_space            = var.vnet_address_space
  subnets                  = var.subnets
  network_security_groups  = var.network_security_groups
  tags                     = var.tags

  depends_on = [module.resource_group]
}
