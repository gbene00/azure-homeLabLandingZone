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

## Azure Network Security Groups
resource "azurerm_network_security_group" "subnet_nsg" {
  for_each = var.nsgs

  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  dynamic "security_rule" {
    for_each = try(each.value.security_rules, [])
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}

## Associate NSGs to Subnets
resource "azurerm_subnet_network_security_group_association" "subnet_nsg_assoc" {
  for_each = var.nsgs

  subnet_id                 = azurerm_subnet.spoke_subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.subnet_nsg[each.key].id
}
