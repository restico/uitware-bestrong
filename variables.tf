variable "subscription_id" {
  description = "The Azure Subscription ID"
  type        = string
  sensitive   = true
}

variable "client_id" {
  description = "The Azure Client ID"
  type        = string
  sensitive   = true
}

variable "client_secret" {
  description = "The Azure Client Secret"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "The Azure Tenant ID"
  type        = string
  sensitive   = true
}

variable "sql_server_login" {
  description = "Username to SQL Server"
  type        = string
  sensitive   = true
}
variable "sql_server_password" {
  description = "Password to the MS SQL Server"
  type        = string
  sensitive   = true
}