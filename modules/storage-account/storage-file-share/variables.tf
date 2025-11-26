variable "name" {
  description = "The name of the file share"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "quota" {
  description = "The maximum size of the share, in gigabytes. Must be between 1 and 102400"
  type        = number
  default     = 5120
}

variable "enabled_protocol" {
  description = "The protocol used for the share. Possible values are SMB and NFS"
  type        = string
  default     = "SMB"
}

variable "access_tier" {
  description = "The access tier of the File Share. Possible values are Hot, Cool and TransactionOptimized"
  type        = string
  default     = "TransactionOptimized"
}

variable "metadata" {
  description = "A mapping of metadata to assign to the file share"
  type        = map(string)
  default     = {}
}

variable "acl" {
  description = "One or more acl blocks"
  type = list(object({
    id = string
    access_policy = list(object({
      permissions = string
      start       = optional(string)
      expiry      = optional(string)
    }))
  }))
  default = []
}
