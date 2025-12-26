## Azure Primary Region
variable "location_primary" {
  type    = string
  default = "uksouth"
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
