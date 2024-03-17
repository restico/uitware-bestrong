provider "azurerm" {
  features {
    subscription {
      prevent_cancellation_on_destroy = true
    }
  }

  # Replace this with environment variables on production
  client_id       = var.bestrong-cliend-id
  client_secret   = var.bestrong-client-secret
  tenant_id       = var.bestrong-tenant-id
  subscription_id = var.bestrong-subscription-id
}