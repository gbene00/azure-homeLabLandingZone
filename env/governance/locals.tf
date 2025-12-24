## Azure Regions
locals {
  allowed_locations = [
    "uksouth",
    "ukwest"
  ]

## Azure Required Tags
  required_tags = [
    "owner",
    "environment",
    "costcenter",
    "workload",
    "managedBy"
  ]

## Azure Default Tags
  default_tags = {
    owner       = "gabriel"
    costcenter  = "homelab"
    managedBy   = "terraform"
  }
}
