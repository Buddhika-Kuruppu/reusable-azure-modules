variable "name" {
  description = "The name of the private DNS zone"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "virtual_network_links" {
  description = "Map of virtual network links to create"
  type = map(object({
    name                 = string
    virtual_network_id   = string
    registration_enabled = optional(bool, false)
  }))
  default = {}
}

variable "a_records" {
  description = "Map of A records to create"
  type = map(object({
    name    = string
    ttl     = number
    records = list(string)
  }))
  default = {}
}

variable "aaaa_records" {
  description = "Map of AAAA records to create"
  type = map(object({
    name    = string
    ttl     = number
    records = list(string)
  }))
  default = {}
}

variable "cname_records" {
  description = "Map of CNAME records to create"
  type = map(object({
    name   = string
    ttl    = number
    record = string
  }))
  default = {}
}

variable "mx_records" {
  description = "Map of MX records to create"
  type = map(object({
    name = string
    ttl  = number
    records = list(object({
      preference = number
      exchange   = string
    }))
  }))
  default = {}
}

variable "ptr_records" {
  description = "Map of PTR records to create"
  type = map(object({
    name    = string
    ttl     = number
    records = list(string)
  }))
  default = {}
}

variable "srv_records" {
  description = "Map of SRV records to create"
  type = map(object({
    name = string
    ttl  = number
    records = list(object({
      priority = number
      weight   = number
      port     = number
      target   = string
    }))
  }))
  default = {}
}

variable "txt_records" {
  description = "Map of TXT records to create"
  type = map(object({
    name    = string
    ttl     = number
    records = list(string)
  }))
  default = {}
}
