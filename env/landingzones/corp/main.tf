## Azure Corp Network Resource Group
module "corp_network_rg" {
  source   = "../../../modules/resource-group"
  name     = "az-lz-corp-network-rg"
  location = var.location_primary
  tags     = var.tags
}

## Azure Corp Spoke Network Module
module "corp_spoke_network" {
  source = "../../../modules/spoke-network"

  resource_group_name = module.corp_network_rg.name
  location            = var.location_primary
  tags                = var.tags

  vnet = {
    name          = "corp-az-lz-vnet"
    address_space = ["10.1.0.0/16"]
  }

  subnets = {
    "az-lz-corp-app-subnet" = { address_prefixes = ["10.1.1.0/24"] }
    "az-lz-corp-aks-subnet" = { address_prefixes = ["10.1.2.0/23"] }
    "az-lz-corp-db-subnet"  = { address_prefixes = ["10.1.10.0/24"] }
  }

  depends_on = [
    module.corp_network_rg
  ]
}

## Azure Corp Hub to Spoke VNet Peering
module "corp_hub_peering" {
  source = "../../../modules/peering"

  hub = {
    name                = data.terraform_remote_state.platform.outputs.hub_vnet_name
    resource_group_name = data.terraform_remote_state.platform.outputs.hub_vnet_rg_name
    id                  = data.terraform_remote_state.platform.outputs.hub_vnet_id
  }

  spoke = {
    name                = module.corp_spoke_network.spoke_vnet_name
    resource_group_name = module.corp_network_rg.name
    id                  = module.corp_spoke_network.spoke_vnet_id
  }

  depends_on = [
    module.corp_spoke_network
  ]
}
