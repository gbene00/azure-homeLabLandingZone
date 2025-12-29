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

## AKS Configuration
variable "aks" {
  description = "AKS configuration (map-driven, enable/disable)."
  type = object({
    enabled            = bool
    name               = string
    kubernetes_version = string
    node_pool = object({
      name                = string
      vm_size             = string
      node_count          = number
      enable_auto_scaling = bool
      min_count           = number
      max_count           = number
      os_disk_size_gb     = number
    })
  })

  default = {
    enabled            = false
    name               = "az-lz-corp-aks"
    kubernetes_version = ""
    node_pool = {
      name                = "sysnp"
      vm_size             = "Standard_B2s"
      node_count          = 1
      enable_auto_scaling = false
      min_count           = 1
      max_count           = 2
      os_disk_size_gb     = 30
    }
  }
}
