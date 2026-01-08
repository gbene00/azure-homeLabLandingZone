## Azure Primary Location
variable "location_primary" {
  type    = string
  default = "uksouth"
}

## Azure Tags
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

## Azure Online Landing Zone Static Site Configuration
variable "static_site" {
  description = "Online landing zone static site configuration."
  type = object({
    enabled = bool
    storage_account = object({
      name                     = string
      account_tier             = optional(string, "Standard")
      account_replication_type = optional(string, "LRS")
      index_document           = optional(string, "index.html")
      error_404_document       = optional(string, "404.html")
    })
    cdn = optional(object({
      enabled       = optional(bool, false)
      profile_name  = optional(string, null)
      endpoint_name = optional(string, null)
    }), {})
  })
}