# Data source to retrieve outputs from networking stage
data "terraform_remote_state" "networking" {
  backend = "azurerm"
  config = {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstatestorage"
    container_name       = "tfstate"
    key                  = "dev-01-networking.tfstate"
  }
}

# Data source to retrieve outputs from general-infra stage
data "terraform_remote_state" "general_infra" {
  backend = "azurerm"
  config = {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstatestorage"
    container_name       = "tfstate"
    key                  = "dev-02-general-infra.tfstate"
  }
}
