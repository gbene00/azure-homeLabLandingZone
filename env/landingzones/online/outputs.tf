output "online_network_rg_name" {
  description = "Online landing zone network resource group name."
  value       = module.online_network_rg.name
}

output "online_spoke_vnet_id" {
  description = "Online spoke VNet ID."
  value       = module.online_spoke_network.spoke_vnet_id
}

output "online_spoke_vnet_name" {
  description = "Online spoke VNet name."
  value       = module.online_spoke_network.spoke_vnet_name
}

output "online_subnet_ids" {
  description = "Online subnet IDs keyed by subnet name."
  value       = module.online_spoke_network.subnet_ids
}

output "online_peering_ids" {
  description = "Online hub/spoke peering IDs."
  value = {
    hub_to_spoke   = module.online_hub_peering.hub_to_spoke_peering_id
    spoke_to_hub   = module.online_hub_peering.spoke_to_hub_peering_id
  }
}

output "online_nsg_ids" {
  description = "Online NSG IDs keyed by subnet name."
  value       = module.online_spoke_network.nsg_ids
}