output "budget_ids" {
  description = "Map of budget ids keyed by budgets map key. Loop over each created budget instance"
  value       = { for k, v in azurerm_consumption_budget_subscription.budget_subscription : k => v.id }
}
