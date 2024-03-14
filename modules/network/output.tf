output "web_app-subnet_id" {
  value = azurerm_subnet.web_app-bestrong-subnet.id
}

output "database-subnet_id" {
  value = azurerm_subnet.database-bestrong-subnet.id
}