locals {
  built_in_policy_definition_ids = {
    allowed_locations        = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"
    require_tag_on_resources = "/providers/Microsoft.Authorization/policyDefinitions/871b8d14-10aa-478d-b590-94f262ecfa99"
  }

  policy_definition_id = try(local.built_in_policy_definition_ids[var.policy_type], null)
}

## Azure Policy Assignment
resource "azurerm_subscription_policy_assignment" "policy_assignment" {
  name                 = var.name
  display_name         = var.name
  description          = var.description
  subscription_id      = var.subscription_id
  policy_definition_id = local.policy_definition_id
  parameters = jsonencode(var.parameters)

  lifecycle {
    precondition {
      condition     = local.policy_definition_id != null
      error_message = "Unsupported policy_type '${var.policy_type}'. Supported: allowed_locations, require_tag_on_resources."
    }
  }
}

