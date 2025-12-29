variable "name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }

## AKS DNS Prefix
variable "dns_prefix" {
  type    = string
  default = null
}

## AKS Kubernetes Version
variable "kubernetes_version" {
  type    = string
  default = null
}

## AKS Subnet ID
variable "subnet_id" {
  description = "Subnet ID for AKS nodes."
  type        = string
}

## Azure Log Analytics Workspace ID
variable "log_analytics_workspace_id" {
  type = string
}

## AKS Node Pool Configuration
variable "node_pool" {
  type = object({
    name                = string
    vm_size             = string
    node_count          = number
    min_count           = number
    max_count           = number
    enable_auto_scaling = bool
    os_disk_size_gb     = number
  })
}

## Azure Tags
variable "tags" {
  type    = map(string)
  default = {}
}
