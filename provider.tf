provider "azurerm" {
  features {}
  subscription_id = var.subscription-id
  tenant_id       = var.tenant-id
  client_id       = var.client-id
  client_secret   = var.client-secret
}