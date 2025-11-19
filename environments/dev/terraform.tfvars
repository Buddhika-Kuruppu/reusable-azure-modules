# Development Environment Configuration

location            = "eastus"
resource_group_name = "rg-dev-001"
vnet_name           = "vnet-dev-001"
vnet_address_space  = ["10.0.0.0/16"]

subnets = {
  subnet1 = {
    address_prefixes       = ["10.0.1.0/24"]
    network_security_group = "sec-ae-nsg-dev-0"
    delegations = {
      appservice = {
        name    = "Microsoft.Web/serverFarms"
        actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
    }
  }
  subnet2 = {
    address_prefixes       = ["10.0.2.0/24"]
    network_security_group = "sec-ae-nsg-dev-1"
  }
  subnet3 = {
    address_prefixes       = ["10.0.3.0/24"]
    network_security_group = "sec-ae-nsg-dev-2"
  }
  subnet4 = {
    address_prefixes       = ["10.0.4.0/24"]
    network_security_group = "sec-ae-nsg-dev-3"
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
  sec-ae-nsg-dev-2 = {
    rules = [
      {
        name                       = "Allow-HTTPS"
        priority                   = 100
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
  sec-ae-nsg-dev-3 = {
    rules = [
      {
        name                       = "Allow-Custom"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "8080"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
}

network_tags = {
  Environment  = "Development"
  ManagedBy    = "Terraform"
  Project      = "Azure-Infrastructure"
  ResourceType = "Network"
}

infra_tags = {
  Environment  = "Development"
  ManagedBy    = "Terraform"
  Project      = "Azure-Infrastructure"
  ResourceType = "Infrastructure"
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
