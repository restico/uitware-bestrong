resource "azurerm_storage_account" "web-app-storage-account" {
  name                     = "webappstoracctflab"
  resource_group_name      = var.az_rg_name
  location                 = var.az_region
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_private_endpoint" "storage_private_endpoint" {
  depends_on = [ azurerm_linux_web_app.linux-web-app ]
  name                = "storage-endpoint"
  location            = var.az_region
  resource_group_name = var.az_rg_name
  subnet_id           = var.db-subnet-id

  private_service_connection {
    name                           = "storage-connection"
    private_connection_resource_id = azurerm_storage_account.web-app-storage-account.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
}

resource "azurerm_service_plan" "service-plan" {
  name                = var.app-service-plan-name
  location            = var.az_region
  resource_group_name = var.az_rg_name

  os_type  = "Linux"
  sku_name = var.app-srv-sku

  zone_balancing_enabled = false
}

resource "azurerm_linux_web_app" "linux-web-app" {
  depends_on = [ azurerm_service_plan.service-plan ]
  name                = var.web-app-name
  resource_group_name = var.az_rg_name
  location            = var.az_region
  service_plan_id     = azurerm_service_plan.service-plan.id

  site_config {
    application_stack {
      docker_registry_url = "https://mcr.microsoft.com"
      docker_image_name   = "appsvc/staticsite:latest"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  app_settings = {
    "APP_INSIGHTS_INSTRUMENTATION_KEY"           = azurerm_application_insights.web-app-insights.instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING"      = azurerm_application_insights.web-app-insights.connection_string
    "ApplicationInsightsAgent_EXTENSION_VERSION" = "~3"

  }

  storage_account {
    access_key   = azurerm_storage_account.web-app-storage-account.primary_access_key
    account_name = azurerm_storage_account.web-app-storage-account.name
    name         = "fileshare"
    share_name   = "fileshare"
    type         = "AzureFiles"
    mount_path   = "/fileshare"
  }

  virtual_network_subnet_id = var.web-app-subnet-id
}

resource "azurerm_log_analytics_workspace" "web-app-logs-workspace" {
  name                = "web-app-logs-workspace"
  location            = var.az_region
  resource_group_name = var.az_rg_name
  sku                 = "PerGB2018"
}

resource "azurerm_application_insights" "web-app-insights" {
  name                = "${var.web-app-name}-insights"
  location            = var.az_region
  resource_group_name = var.az_rg_name
  workspace_id        = azurerm_log_analytics_workspace.web-app-logs-workspace.id
  application_type    = "web"
}

resource "azurerm_app_service_virtual_network_swift_connection" "webapp-vnet-integration" {
  app_service_id = azurerm_linux_web_app.linux-web-app.id
  subnet_id      = var.web-app-subnet-id
}

resource "azurerm_container_registry" "container-registry" {
  name                = var.container-registry-name
  resource_group_name = var.az_rg_name
  location            = var.az_region
  sku                 = var.acr_sku
}

resource "azurerm_role_assignment" "web-service-acr-pull" {
  scope                = azurerm_container_registry.container-registry.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_linux_web_app.linux-web-app.identity[0].principal_id
}

resource "azurerm_key_vault" "test-key-vault" {
  name                = "test-kv-restico-tflab"
  location            = var.az_region
  resource_group_name = var.az_rg_name
  sku_name            = "standard"
  tenant_id           = var.tenant-id

  network_acls {
    bypass                     = "AzureServices"
    default_action             = "Deny"
    virtual_network_subnet_ids = [var.db-subnet-id]
  }

  access_policy {
    tenant_id = var.tenant-id
    object_id = var.client-id

    secret_permissions = [
      "Get", "List", "Set", "Delete"
    ]
    key_permissions = [
      "Get", "List", "Create", "Delete"
    ]
    storage_permissions = [
      "Get", "List", "Set", "Delete"
    ]
  }
}

resource "azurerm_role_assignment" "key-vault-role-assginment" {
  scope                = azurerm_key_vault.test-key-vault.id
  role_definition_name = "Key Vault Contributor"
  principal_id         = azurerm_linux_web_app.linux-web-app.identity[0].principal_id
}