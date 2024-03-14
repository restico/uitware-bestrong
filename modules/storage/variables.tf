variable "bestrong-rg" {
  type = string
}

variable "bestrong-region" {
  type = string
}

variable "bestrong-mssql-server_name" {
  type    = string
  default = "bestrong-db-restico"
}

variable "bestrong-mssql-admin_username" {
  type = string
}

variable "bestrong-mssql-admin_password" {
  type      = string
  sensitive = true
}

variable "bestrong-database-subnet_id" {
  type = string
}

variable "bestrong-mssql-database_name" {
  type    = string
  default = "bestrong-mssql-db-restico"
}

variable "bestrong-mssql-database-sku_name" {
  type    = string
  default = "S0"
}

variable "bestrong-mssql-account_type" {
  type    = string
  default = "Local"
}

variable "bestrong-acr_name" {
  description = "The name of the Azure Container Registry"
  type        = string
  default     = "bestrongacrrestico"
}

variable "bestrong-acr_sku" {
  type    = string
  default = "Basic"
}

variable "bestrong-web_app-identity" {
  type = string
}

variable "bestrong-key_vault_name" {
  type    = string
  default = "bestrong-keva-restico"
}

variable "bestrong-tenant_id" {
  type = string
}

variable "bestrong-key_vault-sku" {
  type    = string
  default = "standard"
}