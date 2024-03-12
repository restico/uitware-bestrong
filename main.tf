data "azurerm_resource_group" "uitware-tflab-rg" {
  name = "uitware-tflab-rg"
}

module "networking" {
  source = "./modules/networking"

  az_rg_name = data.azurerm_resource_group.uitware-tflab-rg.name
  az_region  = data.azurerm_resource_group.uitware-tflab-rg.location
}


module "app-service" {
  source = "./modules/app-service"

  az_rg_name  = data.azurerm_resource_group.uitware-tflab-rg.name
  az_region   = data.azurerm_resource_group.uitware-tflab-rg.location
  app-srv-sku = "B1"

  web-app-name      = "uitware-tflab-web-app"
  web-app-subnet-id = module.networking.subnet_id

  tenant-id = var.tenant-id
}

module "database" {
  source = "./modules/database"

  az_rg_name = data.azurerm_resource_group.uitware-tflab-rg.name
  az_region  = data.azurerm_resource_group.uitware-tflab-rg.location

  sql_server_login    = var.sql-server-user
  sql_server_password = var.sql-server-password

  web-app-subnet-id = module.networking.subnet_id
}