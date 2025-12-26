output "policy_assignment_id" {
  description = "Policy assignment resource ID."
  value       = azurerm_subscription_policy_assignment.policy_assignment.id
}

output "policy_definition_id" {
  description = "Policy definition ID used by the assignment."
  value       = azurerm_subscription_policy_assignment.policy_assignment.policy_definition_id
}
