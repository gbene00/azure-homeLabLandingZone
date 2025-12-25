## Deployment environment
variable "environment" {
  description = "Deployment environment (dev, tst, acc, prd)"
  type        = string
  default     = "dev"
}

## Azure Primary Region
variable "location_primary" {
  description = "Primary Azure region"
  type        = string
  default     = "uksouth"
}

## Azure Tags
variable "tags" {
  description = "Base tags applied to platform resources"
  type        = map(string)
  default = {
    owner       = "gabriel"
    environment = "dev"
    costcenter  = "homelab"
    workload    = "platform"
    managedBy   = "terraform"
  }
}