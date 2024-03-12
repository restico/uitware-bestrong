variable "tenant-id" {
  description = "The Azure Tenant ID"
  type        = string
  sensitive   = true
}

variable "sql-server-user" {
  description = "Username to SQL Server"
  type        = string
  sensitive   = true
}
variable "sql-server-password" {
  description = "Password to the MS SQL Server"
  type        = string
  sensitive   = true
}
variable "client-id" {
  description = "The Azure Client ID"
  type        = string
  sensitive   = true
}

variable "client-secret" {
  type        = string
  description = "The Azure Client Secret"
  sensitive   = true
}

variable "subscription-id" {
  description = "The Azure Subscription ID"
  type        = string
  sensitive   = true
}