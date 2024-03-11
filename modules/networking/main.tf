resource "azurerm_network_security_group" "name" {
  name                = "vnet-security-group"
  location            = var.az_region
  resource_group_name = var.az_rg_name
}

resource "azurerm_virtual_network" "virtual-network" {
  name                = var.vnet-name
  location            = var.az_region
  resource_group_name = var.az_rg_name

  address_space = ["192.168.0.0/24"]
  subnet {
    name           = "subnet-1"
    address_prefix = "192.168.0.0/25"
  }
}