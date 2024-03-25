provider "azurerm" {
  features {
    subscription {
      prevent_cancellation_on_destroy = true
    }
  }
  # Replace this with environment variables on production
  # When run localy, uncomment the following lines
  /*client_id       = var.bestrong-client-id
  client_secret   = var.bestrong-client-secret
  tenant_id       = var.bestrong-tenant-id
  subscription_id = var.bestrong-subscription-id*/
}
