## Local Variables for Governance
locals {
  allowed_locations = [
    "uksouth",
    "ukwest"
  ]

  required_tags = [
    "owner",
    "environment",
    "costcenter",
    "workload",
    "managedBy"
  ]

  default_tags = {
    owner      = "gabriel"
    costcenter = "homelab"
    managedBy  = "terraform"
  }
}