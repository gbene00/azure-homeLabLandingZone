# Hub Network Module

Creates the hub virtual network used by all landing zones.

## Resources created

- `azurerm_virtual_network`
- `azurerm_subnet`
- `azurerm_nat_gateway` (optional)
- `azurerm_subnet_nat_gateway_association`

## Scope

The hub network provides:
- shared connectivity
- centralized routing
- outbound internet access
