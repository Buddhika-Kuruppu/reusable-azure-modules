# reusable-azure-modules

Reusable Terraform modules for Azure infrastructure.

## Available Modules

- **resource-group**: Creates Azure Resource Groups
- **virtual-network**: Creates Virtual Networks with Subnets and Network Security Groups
- **subnet**: Creates standalone subnets within existing Virtual Networks
- **network-security-group**: Creates Network Security Groups with custom security rules
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

### Subnet

```hcl
module "subnet" {
  source = "../../modules/subnet"

  name                   = "my-subnet"
  resource_group_name    = module.resource_group.name
  virtual_network_name   = module.virtual_network.name
  address_prefixes       = ["10.0.3.0/24"]

  # Optional: Associate with an NSG
  network_security_group_id = module.nsg.id

  # Optional: Add delegations
  delegations = {
    sqlmi = {
      name    = "Microsoft.Sql/managedInstances"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}
```

### Network Security Group

```hcl
module "nsg" {
  source = "../../modules/network-security-group"

  name                = "my-nsg"
  location            = "eastus"
  resource_group_name = module.resource_group.name

  security_rules = [
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
      description                = "Allow HTTPS traffic"
    },
    {
      name                       = "allow-ssh"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "10.0.0.0/8"
      destination_address_prefix = "*"
      description                = "Allow SSH from internal network"
    }
  ]

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
│   ├── subnet/
│   ├── network-security-group/
│   └── vnet-peering/
└── environments/
    ├── dev/
    ├── staging/
    └── prod/
```

## Deployment Sequence

The following sequence diagram illustrates the deployment flow across the three-stage infrastructure:

```mermaid
sequenceDiagram
    participant User
    participant TFState as Azure Blob TFState
    participant Networking as Stage 01 - Networking
    participant General as Stage 02 - General Infra
    participant Apps as Stage 03 - Applications

    User->>Networking: terraform apply (environments/dev/01-networking)
    activate Networking
    Networking->>TFState: write state (dev-01-networking.tfstate)
    TFState-->>Networking: ack
    Networking-->>User: outputs (vnet_id, subnet_ids, nsg_ids)
    deactivate Networking

    User->>General: terraform apply (environments/dev/02-general-infra)
    activate General
    General->>TFState: read state (dev-01-networking.tfstate)
    TFState-->>General: networking outputs
    General->>TFState: write state (dev-02-general-infra.tfstate)
    TFState-->>General: ack
    General-->>User: outputs (storage_account_id, networking_vnet_id)
    deactivate General

    User->>Apps: terraform apply (environments/dev/03-applications)
    activate Apps
    Apps->>TFState: read state (dev-01-networking.tfstate)
    TFState-->>Apps: networking outputs
    Apps->>TFState: read state (dev-02-general-infra.tfstate)
    TFState-->>Apps: general infra outputs
    Apps->>TFState: write state (dev-03-applications.tfstate)
    TFState-->>Apps: ack
    Apps-->>User: outputs (app_service_plan_id, logic_app_id)
    deactivate Apps
```

## Requirements

- Terraform >= 1.0
- AzureRM Provider ~> 3.0
