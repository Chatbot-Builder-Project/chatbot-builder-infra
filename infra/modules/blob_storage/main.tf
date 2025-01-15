resource "azurerm_storage_account" "storage_account" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  access_tier              = "Cool"
}

resource "azurerm_storage_container" "blob_container" {
  name                  = "default-container"
  storage_account_id    = azurerm_storage_account.storage_account.id
  container_access_type = var.container_access_type
}

resource "azurerm_storage_account_network_rules" "network_rules" {
  storage_account_id = azurerm_storage_account.storage_account.id
  default_action     = "Allow"
}