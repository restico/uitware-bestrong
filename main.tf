data "azurerm_resource_group" "uitware-tflab-rg" {
  name = "uitware-tflab-rg"
}

module "networking" {
  source     = "./modules/networking"
  az_rg_name = data.azurerm_resource_group.uitware-tflab-rg.name
  az_region  = data.azurerm_resource_group.uitware-tflab-rg.location
}
