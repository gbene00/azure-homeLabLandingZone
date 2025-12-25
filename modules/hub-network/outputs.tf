output "hub_vnet_id" {
  description = "Hub VNet ID."
  value       = azurerm_virtual_network.hub_vnet.id
}

output "hub_vnet_name" {
  description = "Hub VNet name."
  value       = azurerm_virtual_network.hub_vnet.name
}

output "subnet_ids" {
  description = "Map of subnet IDs keyed by subnet name."
  value       = { for k, v in azurerm_subnet.hub_subnet : k => v.id }
}

output "nat_gateway_id" {
  description = "NAT Gateway ID."
  value       = length(azurerm_nat_gateway.nat_gateway) > 0 ? azurerm_nat_gateway.nat_gateway[0].id : null
}
