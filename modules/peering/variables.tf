## Azure Hub and Spoke VNet Peering Variables
variable "hub" {
  description = "Hub VNet info."
  type = object({
    name                = string
    resource_group_name = string
    id                  = string
  })
}

variable "spoke" {
  description = "Spoke VNet info."
  type = object({
    name                = string
    resource_group_name = string
    id                  = string
  })
}

## VNet Peering Settings
variable "allow_forwarded_traffic" {
  type    = bool
  default = true
}

variable "use_remote_gateways" {
  type    = bool
  default = false
}

variable "allow_gateway_transit" {
  type    = bool
  default = false
}
