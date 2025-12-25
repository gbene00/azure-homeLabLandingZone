output "hub_to_spoke_peering_id" {
  value       = azurerm_virtual_network_peering.hub_to_spoke_peering.id
  description = "Hub-to-spoke peering ID."
}

output "spoke_to_hub_peering_id" {
  value       = azurerm_virtual_network_peering.spoke_to_hub_peering.id
  description = "Spoke-to-hub peering ID."
}
