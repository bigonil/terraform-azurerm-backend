provider "azurerm" {
  features {}
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
}

variable "tenant_id" {
  description = "The Azure Active Directory tenant ID"
  type        = string
}

variable "subscription_id" {
  description = "The Azure subscription ID"
  type        = string
}

variable "client_id" {
  description = "The Azure client ID"
  type        = string
}

variable "client_secret" {
  description = "The Azure client secret"
  type        = string
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