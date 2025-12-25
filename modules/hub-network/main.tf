## Azure Hub Virtual Network
resource "azurerm_virtual_network" "hub_vnet" {
  name                = var.vnet.name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet.address_space
  tags                = var.tags
}

## Azure Subnets
resource "azurerm_subnet" "hub_subnet" {
  for_each = var.subnets

  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = each.value.address_prefixes
}

## Azure NAT Gateway Public IP
resource "azurerm_public_ip" "nat_public_ip" {
  count               = var.nat_gateway.enabled ? 1 : 0
  name                = var.nat_gateway.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name

  allocation_method = "Static"
  sku               = try(var.nat_gateway.sku, "Standard")

  tags = var.tags
}

## Azure NAT Gateway
resource "azurerm_nat_gateway" "nat_gateway" {
  count               = var.nat_gateway.enabled ? 1 : 0
  name                = var.nat_gateway.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name                = try(var.nat_gateway.sku, "Standard")
  idle_timeout_in_minutes = try(var.nat_gateway.idle_timeout_minutes, 10)

  tags = var.tags
}

## Associate Public IP to NAT Gateway
resource "azurerm_nat_gateway_public_ip_association" "nat_pip_assoc" {
  count                = var.nat_gateway.enabled ? 1 : 0
  nat_gateway_id       = azurerm_nat_gateway.nat_gateway[0].id
  public_ip_address_id = azurerm_public_ip.nat_public_ip[0].id
}

## Associate NAT to selected subnets
resource "azurerm_subnet_nat_gateway_association" "nat_subnet_assoc" {
  for_each = var.nat_gateway.enabled ? toset(var.nat_gateway.subnet_names) : toset([])

  subnet_id      = azurerm_subnet.hub_subnet[each.value].id
  nat_gateway_id = azurerm_nat_gateway.nat_gateway[0].id
}
