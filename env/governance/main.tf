## Azure Subscription Data
data "azurerm_subscription" "current" {}

## Azure Policy to restrict allowed locations
module "policy_allowed_locations" {
  source = "../../modules/policy-baseline"

  name            = "alz-allowed-locations"
  description     = "Restrict resource deployment to UK South and UK West"
  policy_type     = "allowed_locations"
  subscription_id = data.azurerm_subscription.current.subscription_id

  parameters = {
    listOfAllowedLocations = {
      value = local.allowed_locations
    }
  }
}

## Azure Policy to require tags on resources
module "policy_require_tags" {
  source = "../../modules/policy-baseline"

  for_each = toset(local.required_tags)

  name            = "alz-require-tag-${each.value}"
  description     = "Require tag '${each.value}' on resources"
  policy_type     = "require_tag_on_resources"
  subscription_id = data.azurerm_subscription.current.subscription_id

  parameters = {
    tagName = {
      value = each.value
    }
    tagValue = {
      value = "*"
    }
  }
}