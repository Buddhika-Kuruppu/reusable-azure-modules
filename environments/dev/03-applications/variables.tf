variable "location" {
  description = "The Azure region for resources"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "The name of the resource group for applications"
  type        = string
  default     = "rg-dev-apps-001"
}

variable "app_tags" {
  description = "A mapping of tags to assign to application resources"
  type        = map(string)
  default = {
    Environment  = "Development"
    ManagedBy    = "Terraform"
    Project      = "Azure-Infrastructure"
    ResourceType = "Application"
  }
}

# App Service Plan Variables
variable "app_service_plan_name" {
  description = "The name of the App Service Plan"
  type        = string
  default     = "asp-dev-001"
}

variable "app_service_plan_os_type" {
  description = "The OS type for the App Service Plan"
  type        = string
  default     = "Windows"
}

variable "app_service_plan_sku_name" {
  description = "The SKU name for the App Service Plan"
  type        = string
  default     = "S1"
}

# Logic App Standard Variables
variable "logic_app_name" {
  description = "The name of the Logic App Standard"
  type        = string
  default     = "logic-dev-001"
}

variable "logic_app_enabled" {
  description = "Enable or disable the Logic App"
  type        = bool
  default     = true
}

# API Management Variables
variable "apim_name" {
  description = "The name of the API Management instance"
  type        = string
  default     = "apim-dev-001"
}

variable "apim_publisher_name" {
  description = "The publisher name for API Management"
  type        = string
  default     = "My Company"
}

variable "apim_publisher_email" {
  description = "The publisher email for API Management"
  type        = string
  default     = "admin@example.com"
}

variable "apim_sku_name" {
  description = "The SKU name for API Management"
  type        = string
  default     = "Developer_1"
}
