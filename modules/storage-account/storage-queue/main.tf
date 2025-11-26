resource "azurerm_storage_queue" "this" {
  name                 = var.name
  storage_account_name = var.storage_account_name
  metadata             = var.metadata
}
