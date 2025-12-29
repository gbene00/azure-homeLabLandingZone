data "azurerm_policy_definition" "require_tag_on_resources" {
  display_name = "Require a tag on resources"
}

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

    nsgs = {
    "az-lz-corp-app-subnet" = {
      name = "nsg-az-lz-corp-app"
    }
    "az-lz-corp-aks-subnet" = {
      name = "nsg-az-lz-corp-aks"
    }
    "az-lz-corp-db-subnet" = {
      name = "nsg-az-lz-corp-db"
    }
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

## Azure Corp Workloads Resource Group
module "corp_workloads_rg" {
  source   = "../../../modules/resource-group"
  name     = "az-lz-corp-workload-rg"
  location = var.location_primary
  tags     = merge(var.tags, { workload = "corp-workloads" })
}

## Azure Corp Workloads Resource Group - Require Tags
module "corp_workloads_require_tags" {
  source = "../../../modules/policy-baseline-rg"

  for_each = toset(local.required_tags)

  name              = "alz-require-tag-${each.value}-corp-workloads"
  description       = "Require tag '${each.value}' on corp workloads RG"
  resource_group_id = module.corp_workloads_rg.id

  # Built-in: Require a tag on resources
  policy_definition_id = data.azurerm_policy_definition.require_tag_on_resources.id

  parameters = {
    tagName = { value = each.value }
  }

  depends_on = [module.corp_workloads_rg]
}


## Azure Corp AKS Cluster
module "corp_aks" {
  count  = var.aks.enabled ? 1 : 0
  source = "../../../modules/aks"

  name                = var.aks.name
  location            = var.location_primary
  resource_group_name = module.corp_workloads_rg.name

  kubernetes_version = length(var.aks.kubernetes_version) > 0 ? var.aks.kubernetes_version : null

  subnet_id                  = module.corp_spoke_network.subnet_ids["az-lz-corp-aks-subnet"]
  log_analytics_workspace_id = data.terraform_remote_state.platform.outputs.log_analytics_workspace_id

  node_pool = var.aks.node_pool

  tags = merge(var.tags, { workload = "corp-aks" })

  depends_on = [
    module.corp_spoke_network,
    module.corp_workloads_rg
  ]
}

