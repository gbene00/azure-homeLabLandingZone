## Azure Hub and Spoke VNet Peering
resource "azurerm_virtual_network_peering" "hub_to_spoke_peering" {
  name                      = "hub-to-${var.spoke.name}"
  resource_group_name       = var.hub.resource_group_name
  virtual_network_name      = var.hub.name
  remote_virtual_network_id = var.spoke.id

  allow_forwarded_traffic = var.allow_forwarded_traffic
  allow_gateway_transit   = var.allow_gateway_transit
}

## Azure Spoke to Hub VNet Peering
resource "azurerm_virtual_network_peering" "spoke_to_hub_peering" {
  name                      = "${var.spoke.name}-to-hub"
  resource_group_name       = var.spoke.resource_group_name
  virtual_network_name      = var.spoke.name
  remote_virtual_network_id = var.hub.id

  allow_forwarded_traffic = var.allow_forwarded_traffic
  use_remote_gateways     = var.use_remote_gateways
}
