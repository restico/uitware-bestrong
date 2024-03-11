terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.95.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "uitware-tflab-rg"
    storage_account_name = "uitwaretflabstorage"
    container_name       = "remote-state-container"
    key                  = "terraform.tfstate"
  }
}