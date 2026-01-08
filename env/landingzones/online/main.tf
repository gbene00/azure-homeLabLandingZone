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

  nsgs = {
    "az-lz-online-app-subnet" = {
      name = "nsg-az-lz-online-app"
    }
    "az-lz-online-web-subnet" = {
      name = "nsg-az-lz-online-web"
    }
    "az-lz-online-db-subnet" = {
      name = "nsg-az-lz-online-db"
    }
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

## Azure Online Workloads Resource Group
module "online_workloads_rg" {
  source   = "../../../modules/resource-group"
  name     = "az-lz-online-workloads-rg"
  location = var.location_primary
  tags     = merge(var.tags, { workload = "online-workloads" })
}

## Azure Online Static Website Module
module "online_static_site" {
  source = "../../../modules/staticwebsite"

  enabled             = var.static_site.enabled
  resource_group_name = module.online_workloads_rg.name
  location            = var.location_primary
  tags                = var.tags

  storage_account = var.static_site.storage_account
  cdn             = try(var.static_site.cdn, {})

  depends_on = [
    module.online_workloads_rg
  ]
}
