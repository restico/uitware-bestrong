resource "azurerm_network_security_group" "vnet-sg" {
  name                = "vnet-security-group"
  location            = var.az_region
  resource_group_name = var.az_rg_name
}

resource "azurerm_network_security_rule" "ssh_rule" {
  resource_group_name         = var.az_rg_name
  name                        = "SSH"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefix       = "*"
  source_port_range           = "*"
  destination_port_range      = "22"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.vnet-sg.name
}

resource "azurerm_network_security_rule" "web_traffic_rule" {
  resource_group_name         = var.az_rg_name
  name                        = "WebTraffic"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefix       = "*"
  source_port_range           = "*"
  destination_port_ranges     = ["80", "443"]
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.vnet-sg.name
}

resource "azurerm_virtual_network" "virtual-network" {
  name                = var.vnet-name
  location            = var.az_region
  resource_group_name = var.az_rg_name

  address_space = ["192.168.0.0/24"]
}

resource "azurerm_subnet" "vnet-subnet" {
  name                 = "subnet-1"
  resource_group_name  = var.az_rg_name
  virtual_network_name = azurerm_virtual_network.virtual-network.name
  address_prefixes     = ["192.168.0.0/25"]

  delegation {
    name = "delegation"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet" "vnet-db-subnet" {
  name                 = "subnet-2"
  resource_group_name  = var.az_rg_name
  virtual_network_name = azurerm_virtual_network.virtual-network.name
  address_prefixes     = ["192.168.0.128/25"]

  service_endpoints                         = ["Microsoft.KeyVault"]
  private_endpoint_network_policies_enabled = true
}