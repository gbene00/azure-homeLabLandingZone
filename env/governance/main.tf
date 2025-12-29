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