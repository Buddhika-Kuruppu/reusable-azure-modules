# Development Environment Configuration

location            = "eastus"
resource_group_name = "rg-dev-001"
vnet_name           = "vnet-dev-001"
vnet_address_space  = ["10.0.0.0/16"]

subnets = {
  subnet1 = {
    address_prefixes       = ["10.0.1.0/24"]
    network_security_group = "sec-ae-nsg-dev-0"
  }
  subnet2 = {
    address_prefixes       = ["10.0.2.0/24"]
    network_security_group = "sec-ae-nsg-dev-1"
  }
}

network_security_groups = {
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
}

tags = {
  Environment = "Development"
  ManagedBy   = "Terraform"
  Project     = "Azure-Infrastructure"
}
