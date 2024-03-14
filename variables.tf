variable "bestrong-cliend-id" {
  description = "The client ID of the Azure Entra ID application"
  type        = string
}

variable "bestrong-client-secret" {
  description = "The client secret of the Azure Entra ID application"
  type        = string
  sensitive   = true
}

variable "bestrong-tenant-id" {
  description = "The tenant ID of the Azure Entra ID application"
  type        = string
}

variable "bestrong-subscription-id" {
  description = "The subscription ID of the Azure Entra ID application"
  type        = string
}

variable "mssql-admin-username" {
  description = "The username of the SQL Server administrator"
  type        = string
}

variable "mssql-admin-password" {
  description = "The password of the SQL Server administrator"
  type        = string
  sensitive   = true
}