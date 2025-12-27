output "corp_network_rg_name" {
  description = "Corp landing zone network resource group name."
  value       = module.corp_network_rg.name
}

output "corp_spoke_vnet_id" {
  description = "Corp spoke VNet ID."
  value       = module.corp_spoke_network.spoke_vnet_id
}

output "corp_spoke_vnet_name" {
  description = "Corp spoke VNet name."
  value       = module.corp_spoke_network.spoke_vnet_name
}

output "corp_subnet_ids" {
  description = "Corp subnet IDs keyed by subnet name."
  value       = module.corp_spoke_network.subnet_ids
}

output "corp_peering_ids" {
  description = "Corp hub/spoke peering IDs."
  value = {
    hub_to_spoke = module.corp_hub_peering.hub_to_spoke_peering_id
    spoke_to_hub = module.corp_hub_peering.spoke_to_hub_peering_id
  }
}

output "corp_nsg_ids" {
  description = "Corp NSG IDs keyed by subnet name."
  value       = module.corp_spoke_network.nsg_ids
}
