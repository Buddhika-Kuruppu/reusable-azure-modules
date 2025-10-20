# Staging Environment Configuration

location            = "eastus"
resource_group_name = "rg-staging-001"
vnet_name           = "vnet-staging-001"
vnet_address_space  = ["10.1.0.0/16"]

subnets = {
  subnet1 = {
    address_prefixes = ["10.1.1.0/24"]
  }
  subnet2 = {
    address_prefixes = ["10.1.2.0/24"]
  }
}

network_tags = {
  Environment  = "Staging"
  ManagedBy    = "Terraform"
  Project      = "Azure-Infrastructure"
  ResourceType = "Network"
}

infra_tags = {
  Environment  = "Staging"
  ManagedBy    = "Terraform"
  Project      = "Azure-Infrastructure"
  ResourceType = "Infrastructure"
}
