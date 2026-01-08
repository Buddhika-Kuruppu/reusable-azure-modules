variable "name" {
  description = "The name of the private DNS resolver"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where the resource should be created"
  type        = string
}

variable "virtual_network_id" {
  description = "The ID of the virtual network that is linked to the private DNS resolver"
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "inbound_endpoints" {
  description = "Map of inbound endpoints to create"
  type = map(object({
    name                         = string
    subnet_id                    = string
    private_ip_allocation_method = optional(string, "Dynamic")
    private_ip_address           = optional(string, null)
  }))
  default = {}
}

variable "outbound_endpoints" {
  description = "Map of outbound endpoints to create"
  type = map(object({
    name      = string
    subnet_id = string
  }))
  default = {}
}

variable "dns_forwarding_rulesets" {
  description = "Map of DNS forwarding rulesets to create"
  type = map(object({
    name                   = string
    outbound_endpoint_keys = list(string)
  }))
  default = {}
}

variable "forwarding_rules" {
  description = "Map of forwarding rules to create"
  type = map(object({
    name        = string
    ruleset_key = string
    domain_name = string
    enabled     = optional(bool, true)
    target_dns_servers = list(object({
      ip_address = string
      port       = optional(number, 53)
    }))
  }))
  default = {}
}

variable "virtual_network_links" {
  description = "Map of virtual network links for DNS forwarding rulesets"
  type = map(object({
    name               = string
    ruleset_key        = string
    virtual_network_id = string
  }))
  default = {}
}
