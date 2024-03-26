resource "azurerm_service_plan" "bestrong-service-plan" {
  name                = var.bestrong-service_plan-name
  location            = var.bestrong-region
  resource_group_name = var.bestrong-rg
  sku_name            = var.bestrong-service_plan-sku
  os_type             = "Linux"

  zone_balancing_enabled = false
}

resource "azurerm_linux_web_app" "bestrong-web_app" {
  depends_on = [
    azurerm_service_plan.bestrong-service-plan,
    azurerm_application_insights.bestrong_application_insights,
    azurerm_storage_account.bestrong-web_app-storage
  ]

  name                      = var.bestrong-web_app-name
  resource_group_name       = var.bestrong-rg
  location                  = var.bestrong-region
  service_plan_id           = azurerm_service_plan.bestrong-service-plan.id
  virtual_network_subnet_id = var.bestrong-web_app-subnet_id

  storage_account {
    name         = "bestrong-web-app-fileshare"
    account_name = azurerm_storage_account.bestrong-web_app-storage.name
    access_key   = azurerm_storage_account.bestrong-web_app-storage.primary_access_key
    type         = "AzureFiles"
    share_name   = "bestrong-web-app-files"
  }

  site_config {
    application_stack {
      docker_image_name   = "restico/uitware-webapisample:1.0"
      docker_registry_url = "https://index.docker.io"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.bestrong_application_insights.instrumentation_key
  }
}

resource "azurerm_linux_web_app" "test-web-app" {
  name = "cool-restic-webapp-ln"
  resource_group_name = var.bestrong-rg
  location = var.bestrong-region
  service_plan_id = azurerm_service_plan.bestrong-service-plan.id
  virtual_netowrk_subnet_id = var.bestrong-web_app-subnet_id
  site_config {
    application_stack {
      docker_image_name = "nginx:latest"
      docker_registry_url = "https://index.docker.io"
    }
  }
}


resource "azurerm_log_analytics_workspace" "bestrong-log_analytics_workspace" {
  name                = var.bestrong-log_analytics_workspace-name
  location            = var.bestrong-region
  resource_group_name = var.bestrong-rg
  sku                 = "PerGB2018"
}

resource "azurerm_application_insights" "bestrong_application_insights" {
  depends_on = [azurerm_log_analytics_workspace.bestrong-log_analytics_workspace]

  name                = var.bestrong-application_insights_name
  location            = var.bestrong-region
  resource_group_name = var.bestrong-rg
  application_type    = "web"
}

resource "azurerm_storage_account" "bestrong-web_app-storage" {
  name                          = var.bestrong-web_app-storage_name
  location                      = var.bestrong-region
  resource_group_name           = var.bestrong-rg
  account_tier                  = var.bestrong-web_app-storage_tier
  account_replication_type      = var.bestrong-web_app-storage_replication
  public_network_access_enabled = false
}

resource "azurerm_private_endpoint" "bestrong-web_app_storage-private_endpoint" {
  depends_on          = [azurerm_storage_account.bestrong-web_app-storage]
  name                = var.bestrong-web_app-storage_private_endpoint_name
  location            = var.bestrong-region
  resource_group_name = var.bestrong-rg
  subnet_id           = var.bestrong-database-subnet_id

  private_service_connection {
    name                           = "bestrong-web_app_storage-private_service_connection"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.bestrong-web_app-storage.id
    subresource_names              = ["blob"]
  }
}
