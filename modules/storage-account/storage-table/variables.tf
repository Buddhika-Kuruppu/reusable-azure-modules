variable "name" {
  description = "The name of the storage table"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "acl" {
  description = "One or more acl blocks"
  type = list(object({
    id = string
    access_policy = list(object({
      permissions = string
      start       = string
      expiry      = string
    }))
  }))
  default = []
}
