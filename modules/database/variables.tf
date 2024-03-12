variable "az_rg_name" {
  type = string
}

variable "az_region" {
  type = string
}

variable "sql_server_login" {
  type      = string
  sensitive = true
}

variable "sql_server_password" {
  type      = string
  sensitive = true
}

variable "db-subnet-id" {
  type = string
}