## Azure Resource Group Name
variable "resource_group_name" {
  description = "Resource group where the spoke network is created."
  type        = string
}

## Azure Region
variable "location" {
  description = "Azure region."
  type        = string
}

## Azure Spoke VNet
variable "vnet" {
  description = "Spoke VNet configuration."
  type = object({
    name          = string
    address_space = list(string)
  })
}

## Azure Subnets
variable "subnets" {
  description = "Map of subnets to create."
  type = map(object({
    address_prefixes = list(string)
  }))
}

## Azure Tags
variable "tags" {
  description = "Tags applied to spoke network resources."
  type        = map(string)
  default     = {}
}

## Azure Network Security Groups
variable "nsgs" {
  description = "Map of Network Security Groups to create."
  type = map(object({
    name = string

    security_rules = optional(list(object({
      name                       = string
      priority                   = number
      direction                  = string # Inbound/Outbound
      access                     = string # Allow/Deny
      protocol                   = string # Tcp/Udp/*

      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    })), [])
  }))
  default = {}
}
