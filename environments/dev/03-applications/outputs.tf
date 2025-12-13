output "resource_group_name" {
  description = "The name of the applications resource group"
  value       = module.resource_group.name
}

output "resource_group_id" {
  description = "The ID of the applications resource group"
  value       = module.resource_group.id
}

output "app_service_plan_id" {
  description = "The ID of the App Service Plan"
  value       = module.app_service_plan.id
}

output "app_service_plan_name" {
  description = "The name of the App Service Plan"
  value       = module.app_service_plan.name
}

output "logic_app_id" {
  description = "The ID of the Logic App Standard"
  value       = module.logic_app_standard.id
}

output "logic_app_name" {
  description = "The name of the Logic App Standard"
  value       = module.logic_app_standard.name
}

# Uncomment when APIM is enabled
# output "apim_id" {
#   description = "The ID of the API Management instance"
#   value       = module.api_management.id
# }
#
# output "apim_gateway_url" {
#   description = "The gateway URL of the API Management instance"
#   value       = module.api_management.gateway_url
# }
