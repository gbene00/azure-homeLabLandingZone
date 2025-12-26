## Azure Online Network Resource Group
module "online_network_rg" {
  source   = "../../../modules/resource-group"
  name     = "az-lz-online-network-rg"
  location = var.location_primary
  tags     = var.tags
}

## Azure Online Spoke Network Module
module "online_spoke_network" {
  source = "../../../modules/spoke-network"

  resource_group_name = module.online_network_rg.name
  location            = var.location_primary
  tags                = var.tags

  vnet = {
    name          = "online-az-lz-vnet"
    address_space = ["10.2.0.0/16"]
  }

  subnets = {
    "az-lz-online-app-subnet" = { address_prefixes = ["10.2.1.0/24"] }
    "az-lz-online-web-subnet" = { address_prefixes = ["10.2.2.0/24"] }
    "az-lz-online-db-subnet"  = { address_prefixes = ["10.2.10.0/24"] }
  }

  depends_on = [
    module.online_network_rg
  ]
}

## Azure Online Hub to Spoke VNet Peering
module "online_hub_peering" {
  source = "../../../modules/peering"

  hub = {
    name                = data.terraform_remote_state.platform.outputs.hub_vnet_name
    resource_group_name = data.terraform_remote_state.platform.outputs.hub_vnet_rg_name
    id                  = data.terraform_remote_state.platform.outputs.hub_vnet_id
  }

  spoke = {
    name                = module.online_spoke_network.spoke_vnet_name
    resource_group_name = module.online_network_rg.name
    id                  = module.online_spoke_network.spoke_vnet_id
  }

  depends_on = [
    module.online_spoke_network
  ]
}
