locals {
  built_in_policy_ids = {
    allowed_locations = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"

    # AUDIT tag policy (non-blocking, AKS-safe)
    require_tag_on_resources = "/providers/Microsoft.Authorization/policyDefinitions/1e30110a-5ceb-460c-a204-c1c3969c6d62"
  }

  policy_definition_id = try(local.built_in_policy_ids[var.policy_type], null)

  subscription_resource_id = startswith(var.subscription_id, "/subscriptions/") ? var.subscription_id : "/subscriptions/${var.subscription_id}"
}


## Azure Policy Assignment
resource "azurerm_subscription_policy_assignment" "policy_assignment" {
  name                 = var.name
  display_name         = var.name
  description          = var.description
  subscription_id      = local.subscription_resource_id
  policy_definition_id = local.policy_definition_id

  parameters = jsonencode(var.parameters)

  lifecycle {
    precondition {
      condition     = local.policy_definition_id != null
      error_message = "Unsupported policy_type '${var.policy_type}'."
    }
  }
}
