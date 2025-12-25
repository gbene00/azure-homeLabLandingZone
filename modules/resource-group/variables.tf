## Azure Resource Group Name
variable "name" {
  description = "Resource group name."
  type        = string
}

## Azure Region
variable "location" {
  description = "Azure region."
  type        = string
}

## Azure Tags
variable "tags" {
  description = "Tags applied to the resource group."
  type        = map(string)
  default     = {}
}
