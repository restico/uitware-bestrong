resource "azurerm_virtual_network" "vnet-bestrong-westeurope" {
  name                = var.bestrong-vnet-name
  location            = var.bestrong-region
  resource_group_name = var.bestrong-rg

  address_space = var.bestrong-vnet-address-space
}

resource "azurerm_subnet" "web_app-bestrong-subnet" {
  depends_on           = [azurerm_virtual_network.vnet-bestrong-westeurope]
  name                 = var.bestrong-subnets[0]["name"]
  resource_group_name  = var.bestrong-rg
  virtual_network_name = azurerm_virtual_network.vnet-bestrong-westeurope.name
  address_prefixes     = [var.bestrong-subnets[0]["address_prefix"]]

  delegation {
    name = "delegation-bestrong-westeurope"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet" "database-bestrong-subnet" {
  depends_on           = [azurerm_virtual_network.vnet-bestrong-westeurope]
  name                 = var.bestrong-subnets[1]["name"]
  resource_group_name  = var.bestrong-rg
  virtual_network_name = azurerm_virtual_network.vnet-bestrong-westeurope.name
  address_prefixes     = [var.bestrong-subnets[1]["address_prefix"]]

  service_endpoints = ["Microsoft.KeyVault"]
}
