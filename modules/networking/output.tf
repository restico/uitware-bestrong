output "vnet_name" {
  value = azurerm_virtual_network.virtual-network.name
}

output "subnet_id" {
  value = azurerm_subnet.vnet-subnet.id
}

output "db_subnet_id" {
  value = azurerm_subnet.vnet-db-subnet.id
}