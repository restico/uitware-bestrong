terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.95.0"
    }
  }
  backend "azurerm" {
    # This resources shoud be created before running this configuration
    # (storage name and resource group name may be changed)
    resource_group_name  = "rg-bestrong-francecentral"
    storage_account_name = "sabestrongtfstate"
    container_name       = "bestrong-tfstate"
    key                  = "terraform.tfstate"
  }
}