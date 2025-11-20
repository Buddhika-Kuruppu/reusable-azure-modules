variable "name" {
  description = "The name of the storage queue"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "metadata" {
  description = "A mapping of metadata to assign to the storage queue"
  type        = map(string)
  default     = {}
}
