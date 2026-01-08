## Variables for the static website module.
variable "enabled" {
  description = "Enable/disable the static website module."
  type        = bool
  default     = true
}

## Azure Resource Group
variable "resource_group_name" {
  description = "Resource group for the resources."
  type        = string
}

## Azure Location
variable "location" {
  description = "Azure region."
  type        = string
}

## Azure Tags
variable "tags" {
  description = "Tags applied to resources."
  type        = map(string)
  default     = {}
}

## Azure Storage Account for Static Website
variable "storage_account" {
  description = "Static website storage account settings."
  type = object({
    name                     = string
    account_tier             = optional(string, "Standard")
    account_replication_type = optional(string, "LRS")
    index_document           = optional(string, "index.html")
    error_404_document       = optional(string, "404.html")
  })
}

## Azure CDN Settings
variable "cdn" {
  description = "Optional Azure CDN settings."
  type = object({
    enabled       = optional(bool, false)
    profile_name  = optional(string, null)
    endpoint_name = optional(string, null)
  })
  default = {}
}
