## Azure Policy Assignment for Resource Group
resource "azurerm_resource_group_policy_assignment" "policy_assignment" {
  name                 = var.name
  display_name         = var.name
  description          = var.description
  resource_group_id    = var.resource_group_id
  policy_definition_id = var.policy_definition_id
  parameters           = jsonencode(var.parameters)
}
