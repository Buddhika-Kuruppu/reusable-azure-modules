variable "peering_name_source_to_destination" {
  description = "The name of the virtual network peering from source to destination"
  type        = string
}

variable "peering_name_destination_to_source" {
  description = "The name of the virtual network peering from destination to source"
  type        = string
  default     = ""
}

variable "source_vnet_name" {
  description = "The name of the source virtual network"
  type        = string
}

variable "source_vnet_id" {
  description = "The ID of the source virtual network"
  type        = string
}

variable "source_vnet_resource_group_name" {
  description = "The resource group name of the source virtual network"
  type        = string
}

variable "destination_vnet_name" {
  description = "The name of the destination virtual network"
  type        = string
}

variable "destination_vnet_id" {
  description = "The ID of the destination virtual network"
  type        = string
}

variable "destination_vnet_resource_group_name" {
  description = "The resource group name of the destination virtual network"
  type        = string
}

variable "create_reverse_peering" {
  description = "Whether to create the reverse peering (destination to source)"
  type        = bool
  default     = true
}

variable "allow_virtual_network_access" {
  description = "Allow access from the source virtual network to the destination virtual network"
  type        = bool
  default     = true
}

variable "allow_forwarded_traffic" {
  description = "Allow forwarded traffic from the source virtual network to the destination virtual network"
  type        = bool
  default     = false
}

variable "allow_gateway_transit" {
  description = "Allow gateway transit for the source virtual network"
  type        = bool
  default     = false
}

variable "use_remote_gateways" {
  description = "Use remote gateways for the source virtual network"
  type        = bool
  default     = false
}

variable "allow_virtual_network_access_reverse" {
  description = "Allow access from the destination virtual network to the source virtual network"
  type        = bool
  default     = true
}

variable "allow_forwarded_traffic_reverse" {
  description = "Allow forwarded traffic from the destination virtual network to the source virtual network"
  type        = bool
  default     = false
}

variable "allow_gateway_transit_reverse" {
  description = "Allow gateway transit for the destination virtual network"
  type        = bool
  default     = false
}

variable "use_remote_gateways_reverse" {
  description = "Use remote gateways for the destination virtual network"
  type        = bool
  default     = false
}
