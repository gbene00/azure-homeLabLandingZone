variable "name" { type = string }

variable "description" { type = string }

## Azure Resource Group ID
variable "resource_group_id" { type = string }

## Azure Policy Type
variable "policy_definition_id" {
  description = "Built-in policy definition ID."
  type        = string
}

## Azure Policy Parameters
variable "parameters" {
  description = "Policy parameters map."
  type        = any
  default     = {}
}
