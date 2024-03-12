variable "az_rg_name" {
  type = string
}

variable "az_region" {
  type = string
}

variable "app-service-plan-name" {
  type    = string
  default = "uitware-tflab-app-service-plan"
}

variable "app-srv-sku" {
  type    = string
  default = "F1"
}

variable "web-app-name" {
  type    = string
  default = "uitware-tflab-web-app"
}

variable "web-app-subnet-id" {
  type = string
}

variable "container-registry-name" {
  type    = string
  default = "containerregistrytflab"
}

variable "acr_sku" {
  type    = string
  default = "Basic"
}