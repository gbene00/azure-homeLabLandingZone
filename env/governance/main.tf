## Azure Subscription Data Source
data "azurerm_subscription" "current" {}

## Azure Policy: Allowed Locations
module "policy_allowed_locations" {
  source = "../../modules/policy-baseline"

  name             = "alz-allowed-locations"
  description      = "Restrict resource deployment to UK South and UK West"
  policy_type      = "allowed_locations"
  assignment_scope = data.azurerm_subscription.current.id

  parameters = {
    listOfAllowedLocations = {
      value = local.allowed_locations
    }
  }
}

## Azure Policy: Require Tags (built-in policy requires ONE tag per assignment -> create multiple)
module "policy_require_tags" {
  source = "../../modules/policy-baseline"

  for_each = toset(local.required_tags)

  name             = "alz-require-tag-${each.value}"
  description      = "Require tag '${each.value}' on resources"
  policy_type      = "require_tag_on_resources"
  assignment_scope = data.azurerm_subscription.current.id

  parameters = {
    tagName = {
      value = each.value
    }
  }
}
