variable "bestrong-rg" {
  type = string
}

variable "bestrong-region" {
  type = string
}

variable "bestrong-vnet-name" {
  type    = string
  default = "vnet-bestrong-francecentral"
}

variable "bestrong-vnet-address-space" {
  type    = list(string)
  default = ["192.168.0.0/24"]
}

variable "bestrong-subnets" {
  description = "Two subnets in the virtual network."
  type = list(object({
    name           = string
    address_prefix = string
  }))
  default = [{
    name           = "web_app_subnet-bestrong-francecentral"
    address_prefix = "192.168.0.0/25"
    }, {
    name           = "database_subnet-bestrong-francecentral"
    address_prefix = "192.168.0.128/25"
  }]
}