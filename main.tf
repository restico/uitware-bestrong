data "azurerm_resource_group" "rg-bestrong-westeurope" {
  name = "rg-bestrong-francecentral"
}

module "network" {
  source          = "./modules/network"
  bestrong-rg     = data.azurerm_resource_group.rg-bestrong-westeurope.name
  bestrong-region = data.azurerm_resource_group.rg-bestrong-westeurope.location
}

module "app-service" {
  source          = "./modules/app-service"
  bestrong-rg     = data.azurerm_resource_group.rg-bestrong-westeurope.name
  bestrong-region = data.azurerm_resource_group.rg-bestrong-westeurope.location

  bestrong-service_plan-sku   = "S1"
  bestrong-web_app-subnet_id  = module.network.web_app-subnet_id
  bestrong-database-subnet_id = module.network.database-subnet_id
}

module "database" {
  source          = "./modules/storage"
  bestrong-rg     = data.azurerm_resource_group.rg-bestrong-westeurope.name
  bestrong-region = data.azurerm_resource_group.rg-bestrong-westeurope.location

  bestrong-mssql-admin_username = var.mssql-admin-username
  bestrong-mssql-admin_password = var.mssql-admin-password

  bestrong-database-subnet_id = module.network.database-subnet_id
  bestrong-web_app-identity   = module.app-service.bestrong-web_app-identity

  bestrong-tenant_id = var.bestrong-tenant-id
}