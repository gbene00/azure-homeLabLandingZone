## Azure Resource Group Name
variable "resource_group_name" {
  description = "Resource group where logging resources will be created."
  type        = string
}

## Azure Region
variable "location" {
  description = "Azure region for logging resources."
  type        = string
}

## Azure Log Analytics Workspace
variable "log_analytics" {
  description = "Log Analytics Workspace configuration."
  type = object({
    name          = string
    retention_days = number
    sku           = optional(string, "PerGB2018")
  })
}

## Azure Action Groups
variable "action_groups" {
  description = "Map of action groups to create."
  type = map(object({
    name          = string
    short_name    = string
    email_receivers = list(object({
      name  = string
      email = string
    }))
  }))
  default = {}
}

## Azure Tags
variable "tags" {
  description = "Tags applied to logging resources."
  type        = map(string)
  default     = {}
}
