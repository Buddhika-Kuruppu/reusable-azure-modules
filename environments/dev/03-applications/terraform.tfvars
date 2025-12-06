# Development Environment - Applications Stage Configuration

location            = "eastus"
resource_group_name = "rg-dev-apps-001"

app_tags = {
  Environment  = "Development"
  ManagedBy    = "Terraform"
  Project      = "Azure-Infrastructure"
  ResourceType = "Application"
  Stage        = "03-Applications"
}

# App Service Plan Configuration
app_service_plan_name    = "asp-dev-001"
app_service_plan_os_type = "Windows"
app_service_plan_sku_name = "S1"

# Logic App Standard Configuration
logic_app_name    = "logic-dev-001"
logic_app_enabled = true

# API Management Configuration (uncomment when ready to deploy)
# apim_name            = "apim-dev-001"
# apim_publisher_name  = "My Company"
# apim_publisher_email = "admin@example.com"
# apim_sku_name        = "Developer_1"
