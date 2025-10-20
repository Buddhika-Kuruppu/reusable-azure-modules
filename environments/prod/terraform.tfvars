# Production Environment Configuration

location            = "eastus"
resource_group_name = "rg-prod-001"
vnet_name           = "vnet-prod-001"
vnet_address_space  = ["10.2.0.0/16"]

subnets = {
  subnet1 = {
    address_prefixes = ["10.2.1.0/24"]
  }
  subnet2 = {
    address_prefixes = ["10.2.2.0/24"]
  }
}

network_tags = {
  Environment  = "Production"
  ManagedBy    = "Terraform"
  Project      = "Azure-Infrastructure"
  ResourceType = "Network"
}

infra_tags = {
  Environment  = "Production"
  ManagedBy    = "Terraform"
  Project      = "Azure-Infrastructure"
  ResourceType = "Infrastructure"
}
