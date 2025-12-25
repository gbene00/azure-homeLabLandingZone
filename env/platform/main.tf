
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
}

