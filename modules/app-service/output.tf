output "bestrong-web_app-public_hostname" {
  value = join("", ["https://", azurerm_linux_web_app.bs-web_app.default_hostname])
}

output "bestrong-web_app-identity" {
  value = azurerm_linux_web_app.bs-web_app.identity[0].principal_id
}
