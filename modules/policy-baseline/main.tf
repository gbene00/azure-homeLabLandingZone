locals {
  ## Map our "policy_type" to built-in policy display names
  built_in_policy_display_names = {
    allowed_locations        = "Allowed locations"
    require_tag_on_resources = "Require a tag on resources"
  }

  policy_display_name = try(local.built_in_policy_display_names[var.policy_type], null)

  ## Accept either UUID or full resource ID
  subscription_resource_id = startswith(var.subscription_id, "/subscriptions/") ? var.subscription_id : "/subscriptions/${var.subscription_id}"
}

data "azurerm_policy_definition" "built_in" {
  display_name = local.policy_display_name
}

resource "azurerm_subscription_policy_assignment" "policy_assignment" {
  name                 = var.name
  display_name         = var.name
  description          = var.description
  subscription_id      = local.subscription_resource_id
  policy_definition_id = data.azurerm_policy_definition.built_in.id

  parameters = jsonencode(var.parameters)

  lifecycle {
    precondition {
      condition     = local.policy_display_name != null
      error_message = "Unsupported policy_type '${var.policy_type}'. Supported: allowed_locations, require_tag_on_resources."
    }
  }
}
