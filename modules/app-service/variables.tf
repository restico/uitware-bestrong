variable "bestrong-rg" {
  type = string
}

variable "bestrong-region" {
  type = string
}

variable "bestrong-service_plan-name" {
  type    = string
  default = "service-plan-bestrong-francecentral"
}

variable "bestrong-service_plan-sku" {
  type    = string
  default = "F1"
}

variable "bestrong-web_app-name" {
  type    = string
  default = "bestrong-webapp-francecentral"
}

variable "bestrong-web_app-subnet_id" {
  type = string
}

variable "bestrong-log_analytics_workspace-name" {
  type    = string
  default = "log-analytics-bestrong-francecentral"
}

variable "bestrong-application_insights_name" {
  type    = string
  default = "app_insights-bestrong-francecentral"
}

variable "bestrong-web_app-storage_name" {
  description = "Web App Storage Be Strong Restico"
  type        = string
  default     = "wastoragebsrestico"
}

variable "bestrong-web_app-storage_tier" {
  type    = string
  default = "Standard"
}

variable "bestrong-web_app-storage_replication" {
  type    = string
  default = "LRS"
}

variable "bestrong-web_app-storage_private_endpoint_name" {
  type    = string
  default = "bestrong-web_app_storage-private_endpoint"
}

variable "bestrong-database-subnet_id" {
  type = string
}
