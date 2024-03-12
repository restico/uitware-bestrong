resource "azurerm_mssql_server" "database-server" {
  name                         = "tflab-bestrongserver"
  resource_group_name          = var.az_rg_name
  location                     = var.az_region
  version                      = "12.0"
  administrator_login          = var.sql_server_login
  administrator_login_password = var.sql_server_password
}

resource "azurerm_mssql_database" "database-server_db" {
  name        = "bestrongdatabase"
  server_id   = azurerm_mssql_server.database-server.id
  sku_name    = "S0"
  max_size_gb = 4
  zone_redundant = false
  storage_account_type = "Local"
}


resource "azurerm_private_endpoint" "database-server_private_endpoint" {
  name                = "DatabasePrivateEndpoint"
  location            = var.az_region
  resource_group_name = var.az_rg_name
  subnet_id           = var.db-subnet-id

  private_service_connection {
    name                           = "DatabasePrivateServiceConnection"
    private_connection_resource_id = azurerm_mssql_server.database-server.id
    is_manual_connection           = false
    subresource_names              = ["sqlServer"]
  }
}