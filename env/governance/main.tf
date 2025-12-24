data "azurerm_subscription" "current" {}

# Required Tags Policy
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

# Allowed Locations Policy
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
