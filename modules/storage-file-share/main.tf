resource "azurerm_storage_share" "this" {
  name                 = var.name
  storage_account_name = var.storage_account_name
  quota                = var.quota
  enabled_protocol     = var.enabled_protocol
  access_tier          = var.access_tier
  metadata             = var.metadata

  dynamic "acl" {
    for_each = var.acl
    content {
      id = acl.value.id

      dynamic "access_policy" {
        for_each = acl.value.access_policy
        content {
          permissions = access_policy.value.permissions
          start       = access_policy.value.start
          expiry      = access_policy.value.expiry
        }
      }
    }
  }
}
