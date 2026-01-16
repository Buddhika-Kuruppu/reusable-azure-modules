variable "name" {
  description = "The name of the virtual WAN"
  type        = string
}

variable "location" {
  description = "The Azure region where the virtual WAN should exist"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual WAN"
  type        = string
}

variable "disable_vpn_encryption" {
  description = "Boolean flag to specify whether VPN encryption is disabled"
  type        = bool
  default     = false
}

variable "allow_branch_to_branch_traffic" {
  description = "Boolean flag to specify whether branch to branch traffic is allowed"
  type        = bool
  default     = true
}

variable "office365_local_breakout_category" {
  description = "Specifies the Office365 local breakout category. Possible values include: Optimize, OptimizeAndAllow, All, None"
  type        = string
  default     = "None"
}

variable "type" {
  description = "Specifies the type of the Virtual WAN. Possible values are: Basic, Standard"
  type        = string
  default     = "Standard"
}

variable "tags" {
  description = "A mapping of tags to assign to the virtual WAN"
  type        = map(string)
  default     = {}
}
