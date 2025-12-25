## Azure Subscription
data "azurerm_subscription" "current" {}

## Required Tags Policy
module "required_tags_policy" {
  source = "../../modules/policy-baseline"

  name        = "alz-required-tags"
  description = "Require standard tags on all resources"

  policy_type = "require_tags"

  parameters = {
    tagNames = {
      value = local.required_tags
    }
  }

  assignment_scope = data.azurerm_subscription.current.id
}

## Allowed Locations Policy
module "allowed_locations_policy" {
  source = "../../modules/policy-baseline"

  name        = "alz-allowed-locations"
  description = "Restrict resource deployment to approved Azure regions"

  policy_type = "allowed_locations"

  parameters = {
    listOfAllowedLocations = {
      value = local.allowed_locations
    }
  }

  assignment_scope = data.azurerm_subscription.current.id
}

## Azure Budgets Module
module "subscription_budgets" {
  source          = "../../modules/budgets"
  subscription_id = data.azurerm_subscription.current.subscription_id

  budgets = {
    monthly_homelab = {
      name       = "az-lz-budget-monthly-homelab"
      amount     = 50
      time_grain = "Monthly"
      start_date = "2025-12-01"

      notifications = {
        warn_80 = {
          enabled        = true
          operator       = "GreaterThanOrEqualTo"
          threshold      = 80
          contact_emails = ["bene.gabriel3@gmail.com"]
        }
        crit_100 = {
          enabled        = true
          operator       = "GreaterThanOrEqualTo"
          threshold      = 100
          contact_emails = ["bene.gabriel3@gmail.com"]
        }
      }
    }
  }
}

