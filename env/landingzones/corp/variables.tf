## Azure Primary Region
variable "location_primary" {
  type    = string
  default = "uksouth"
}

## Azure Hub VNet ID
variable "hub_vnet_id" {
  description = "Hub VNet ID from platform layer."
  type        = string
}

## Azure Tags
variable "tags" {
  description = "Tags applied to corp resources."
  type        = map(string)
  default = {
    owner       = "gabriel"
    environment = "dev"
    costcenter  = "homelab"
    workload    = "corp"
    managedBy   = "terraform"
  }
}
