## Azure Resource Group Name
variable "resource_group_name" {
  description = "Resource group where the hub network will be created."
  type        = string
}

## Azure Region
variable "location" {
  description = "Azure region."
  type        = string
}

## Azure Hub VNet
variable "vnet" {
  description = "Hub VNet configuration."
  type = object({
    name          = string
    address_space = list(string)
  })
}

## Azure Subnets
variable "subnets" {
  description = "Map of subnets to create within the hub VNet."
  type = map(object({
    address_prefixes = list(string)
  }))
}

## Azure NAT Gateway
variable "nat_gateway" {
  description = "NAT Gateway configuration (optional)."
  type = object({
    enabled             = bool
    name                = string
    public_ip_name      = string
    sku                 = optional(string, "Standard")
    idle_timeout_minutes = optional(number, 10)
    subnet_names        = list(string) # which subnets to associate NAT to
  })
}

## Azure Tags
variable "tags" {
  description = "Tags applied to network resources."
  type        = map(string)
  default     = {}
}
