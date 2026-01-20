variable "name" {
  description = "The name of the Application Gateway"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region"
  type        = string
}

variable "sku_name" {
  description = "The SKU name (e.g., Standard_v2, WAF_v2)"
  type        = string
  default     = "Standard_v2"
}

variable "sku_tier" {
  description = "The SKU tier (e.g., Standard_v2, WAF_v2)"
  type        = string
  default     = "Standard_v2"
}

variable "subnet_id" {
  description = "The subnet ID for Application Gateway"
  type        = string
}

variable "frontend_port" {
  description = "The frontend port number"
  type        = number
  default     = 80
}

variable "backend_fqdns" {
  description = "List of backend FQDNs"
  type        = list(string)
  default     = []
}

variable "backend_ip_addresses" {
  description = "List of backend IP addresses"
  type        = list(string)
  default     = []
}

variable "backend_port" {
  description = "The backend port number"
  type        = number
  default     = 80
}

variable "backend_protocol" {
  description = "The backend protocol (Http or Https)"
  type        = string
  default     = "Http"
}

variable "public_ip_address_id" {
  description = "The public IP address ID for frontend"
  type        = string
  default     = null
}

variable "private_ip_address" {
  description = "The private IP address for frontend"
  type        = string
  default     = null
}

variable "min_capacity" {
  description = "Minimum autoscale capacity"
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Maximum autoscale capacity"
  type        = number
  default     = 10
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}
