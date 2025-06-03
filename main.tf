provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "random_string" "suffix" {
  length  = 6
  upper   = false
  numeric = true
  special = false
}

resource "azurerm_storage_account" "storage" {
  name                     = lower("${var.storage_account_prefix}${random_string.suffix.result}")
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

resource "azurerm_storage_container" "tfstate" {
  name                  = var.container_name
  storage_account_id    = azurerm_storage_account.storage.id
  container_access_type = "private"
}
resource "azurerm_storage_container" "artifacts" {
  name                  = var.artifacts_container_name
  storage_account_id    = azurerm_storage_account.storage.id
  container_access_type = "private"
}