# Development Environment Configuration

location            = "eastus"
resource_group_name = "rg-dev-001"
vnet_name           = "vnet-dev-001"
vnet_address_space  = ["10.0.0.0/16"]

subnets = {
  subnet1 = {
    address_prefixes = ["10.0.1.0/24"]
  }
  subnet2 = {
    address_prefixes = ["10.0.2.0/24"]
  }
}

tags = {
  Environment = "Development"
  ManagedBy   = "Terraform"
  Project     = "Azure-Infrastructure"
}
