resource "azurerm_mssql_server" "bestrong-mssql-server" {
  name                = var.bestrong-mssql-server_name
  location            = var.bestrong-region
  resource_group_name = var.bestrong-rg

  version                      = "12.0"
  administrator_login          = var.bestrong-mssql-admin_username
  administrator_login_password = var.bestrong-mssql-admin_password

  public_network_access_enabled = false
}

resource "azurerm_mssql_database" "bestrong-mssql-database" {
  depends_on           = [azurerm_mssql_server.bestrong-mssql-server]
  name                 = var.bestrong-mssql-database_name
  server_id            = azurerm_mssql_server.bestrong-mssql-server.id
  sku_name             = var.bestrong-mssql-database-sku_name
  storage_account_type = var.bestrong-mssql-account_type
  zone_redundant       = false
}

resource "azurerm_private_endpoint" "bestrong-mssql-private_endpoint" {
  depends_on          = [azurerm_mssql_server.bestrong-mssql-server]
  name                = "bestrong-mssql-private-endpoint"
  location            = var.bestrong-region
  resource_group_name = var.bestrong-rg
  subnet_id           = var.bestrong-database-subnet_id

  private_service_connection {
    name                           = "bestrong-mssql-private-service-connection"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_mssql_server.bestrong-mssql-server.id
    subresource_names              = ["sqlServer"]
  }
}

resource "azurerm_container_registry" "bestrong-container-registry" {
  name                = var.bestrong-acr_name
  resource_group_name = var.bestrong-rg
  location            = var.bestrong-region
  sku                 = var.bestrong-acr_sku
}

resource "azurerm_role_assignment" "bestrong-acr-role-assignment" {
  depends_on           = [azurerm_container_registry.bestrong-container-registry]
  scope                = azurerm_container_registry.bestrong-container-registry.id
  role_definition_name = "AcrPull"
  principal_id         = var.bestrong-web_app-identity
}

resource "azurerm_key_vault" "bestrong-key-vault" {
  name                          = var.bestrong-key_vault_name
  location                      = var.bestrong-region
  resource_group_name           = var.bestrong-rg
  tenant_id                     = var.bestrong-tenant_id
  sku_name                      = var.bestrong-key_vault-sku
  public_network_access_enabled = false
}

resource "azurerm_role_assignment" "bestrong-kv-role-assignment" {
  depends_on           = [azurerm_key_vault.bestrong-key-vault]
  scope                = azurerm_key_vault.bestrong-key-vault.id
  role_definition_name = "Key Vault Reader"
  principal_id         = var.bestrong-web_app-identity
}

resource "azurerm_private_endpoint" "bestrong-key_vault-private_endpoint" {
  depends_on          = [azurerm_key_vault.bestrong-key-vault]
  name                = "bestrong-key-vault-private-endpoint"
  location            = var.bestrong-region
  resource_group_name = var.bestrong-rg
  subnet_id           = var.bestrong-database-subnet_id

  private_service_connection {
    name                           = "bestrong-key-vault-private-service-connection"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_key_vault.bestrong-key-vault.id
    subresource_names              = ["vault"]
  }
}