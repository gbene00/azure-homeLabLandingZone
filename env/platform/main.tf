
## Platform Management Module
module "platform_management_rg" {
  source = "../../modules/resource-group"

  name     = "az-lz-platform-management-rg"
  location = var.location_primary
  tags     = var.tags
}

## Platform Logging Module
module "platform_logging" {
  source = "../../modules/logging"

  resource_group_name = module.platform_management_rg.name
  location            = var.location_primary
  tags                = var.tags

  log_analytics = {
    name           = "az-lz-law"
    retention_days = 30
    sku            = "PerGB2018"
  }

  action_groups = {
    alerts = {
      name       = "az-lz-action-group-alerts"
      short_name = "alzalerts"
      email_receivers = [
        {
          name  = "gabriel"
          email = "bene.gabriel3@gmail.com"
        }
      ]
    }
  }
  depends_on = [
    module.platform_management_rg
  ]
}

## Platform Connectivity Module
module "platform_connectivity_rg" {
  source   = "../../modules/resource-group"
  name     = "az-lz-platform-connectivity-rg"
  location = var.location_primary
  tags     = var.tags
}

## Hub Network + NAT Gateway
module "hub_network" {
  source = "../../modules/hub-network"

  resource_group_name = module.platform_connectivity_rg.name
  location            = var.location_primary
  tags                = var.tags

  vnet = {
    name          = "hub-az-lz-vnet"
    address_space = ["10.0.0.0/16"]
  }

  subnets = {
    "shared-az-lz-subnet" = { address_prefixes = ["10.0.1.0/24"] }
    "mgmt-az-lz-subnet"   = { address_prefixes = ["10.0.2.0/24"] }

    ## Reserved subnet names
    "AzureBastionSubnet"  = { address_prefixes = ["10.0.10.0/26"] }
    "AzureFirewallSubnet" = { address_prefixes = ["10.0.20.0/26"] }
  }

  nat_gateway = {
    enabled              = true
    name                 = "az-lz-natgw"
    public_ip_name       = "az-lz-natgw-pip"
    subnet_names         = ["shared-az-lz-subnet", "mgmt-az-lz-subnet"]
    idle_timeout_minutes = 10
  }
  depends_on = [
    module.platform_connectivity_rg
]
}

