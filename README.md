# reusable-azure-modules

Reusable Terraform modules for Azure infrastructure.

## Available Modules

- **resource-group**: Creates Azure Resource Groups
- **virtual-network**: Creates Virtual Networks with Subnets and Network Security Groups
- **vnet-peering**: Creates bi-directional VNet peering between two Virtual Networks

## Module Usage

### Resource Group

```hcl
module "resource_group" {
  source = "../../modules/resource-group"

  name     = "my-resource-group"
  location = "eastus"
  tags = {
    Environment = "dev"
    Project     = "my-project"
  }
}
```

### Virtual Network

```hcl
module "virtual_network" {
  source = "../../modules/virtual-network"

  name                = "my-vnet"
  location            = "eastus"
  resource_group_name = module.resource_group.name
  address_space       = ["10.0.0.0/16"]

  subnets = {
    subnet1 = {
      address_prefixes = ["10.0.1.0/24"]
    }
    subnet2 = {
      address_prefixes       = ["10.0.2.0/24"]
      network_security_group = "nsg1"
      delegations = {
        sqlmi = {
          name    = "Microsoft.Sql/managedInstances"
          actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        }
      }
    }
  }

  network_security_groups = {
    nsg1 = {
      rules = [
        {
          name                       = "allow-https"
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
  }

  tags = {
    Environment = "dev"
  }
}
```

### VNet Peering

```hcl
module "vnet_peering" {
  source = "../../modules/vnet-peering"

  peering_name_source_to_destination      = "vnet1-to-vnet2"
  peering_name_destination_to_source      = "vnet2-to-vnet1"
  source_vnet_name                        = "vnet1"
  source_vnet_id                          = module.vnet1.vnet_id
  source_vnet_resource_group_name         = module.resource_group1.name
  destination_vnet_name                   = "vnet2"
  destination_vnet_id                     = module.vnet2.vnet_id
  destination_vnet_resource_group_name    = module.resource_group2.name
  create_reverse_peering                  = true
  allow_virtual_network_access            = true
  allow_forwarded_traffic                 = false
  allow_gateway_transit                   = false
  use_remote_gateways                     = false
}
```

## Directory Structure

```
├── modules/
│   ├── resource-group/
│   ├── virtual-network/
│   └── vnet-peering/
└── environments/
    ├── dev/
    ├── staging/
    └── prod/
```

## Requirements

- Terraform >= 1.0
- AzureRM Provider ~> 3.0
