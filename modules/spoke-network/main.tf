## Azure Spoke VNet
resource "azurerm_virtual_network" "spoke_vnet" {
  name                = var.vnet.name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet.address_space
  tags                = var.tags
}

## Azure Subnets
resource "azurerm_subnet" "spoke_subnet" {
  for_each = var.subnets

  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.spoke_vnet.name
  address_prefixes     = each.value.address_prefixes
}
