variable "location_primary" {
  type    = string
  default = "uksouth"
}

variable "tags" {
  description = "Tags applied to online resources."
  type        = map(string)
  default = {
    owner       = "gabriel"
    environment = "dev"
    costcenter  = "homelab"
    workload    = "online"
    managedBy   = "terraform"
  }
}
