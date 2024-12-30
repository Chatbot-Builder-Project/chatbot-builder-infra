output "blob_storage_url" {
  description = "The URL of the blob storage account"
  value       = azurerm_storage_account.storage_account.primary_blob_endpoint
}

output "blob_container_url" {
  description = "The URL of the blob container"
  value       = "${azurerm_storage_account.storage_account.primary_blob_endpoint}default-container"
}
