# Resource Group for Applications
module "resource_group" {
  source = "../../../modules/resource-group"

  name     = var.resource_group_name
  location = var.location
  tags     = var.app_tags
}

# App Service Plan
module "app_service_plan" {
  source = "../../../modules/app-service-plan"

  name                = var.app_service_plan_name
  resource_group_name = module.resource_group.name
  location            = var.location
  os_type             = var.app_service_plan_os_type
  sku_name            = var.app_service_plan_sku_name
  tags                = var.app_tags

  depends_on = [module.resource_group]
}

# Logic App Standard
# Note: Logic App requires storage account and subnet
module "logic_app_standard" {
  source = "../../../modules/logic-app-standard"

  name                       = var.logic_app_name
  resource_group_name        = module.resource_group.name
  location                   = var.location
  app_service_plan_id        = module.app_service_plan.id
  storage_account_name       = data.terraform_remote_state.general_infra.outputs.storage_account_name
  storage_account_access_key = data.terraform_remote_state.general_infra.outputs.storage_account_primary_connection_string
  enabled                    = var.logic_app_enabled
  tags                       = var.app_tags

  depends_on = [module.app_service_plan]
}

# API Management
# Uncomment when ready to deploy APIM (takes ~45 minutes to provision)
# module "api_management" {
#   source = "../../../modules/api-management"
#
#   name                = var.apim_name
#   resource_group_name = module.resource_group.name
#   location            = var.location
#   publisher_name      = var.apim_publisher_name
#   publisher_email     = var.apim_publisher_email
#   sku_name            = var.apim_sku_name
#   tags                = var.app_tags
#
#   depends_on = [module.resource_group]
# }
