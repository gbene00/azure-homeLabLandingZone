output "spoke_vnet_id" {
  description = "Spoke VNet ID."
  value       = azurerm_virtual_network.spoke_vnet.id
}

output "spoke_vnet_name" {
  description = "Spoke VNet name."
  value       = azurerm_virtual_network.spoke_vnet.name
}

output "subnet_ids" {
  description = "Map of subnet IDs keyed by subnet name."
  value       = { for k, v in azurerm_subnet.spoke_subnet : k => v.id }
}

output "nsg_ids" {
  description = "Map of NSG IDs keyed by subnet name."
  value       = { for k, v in azurerm_network_security_group.subnet_nsg : k => v.id }
}

output "nsg_names" {
  description = "Map of NSG names keyed by subnet name."
  value       = { for k, v in azurerm_network_security_group.subnet_nsg : k => v.name }
}
