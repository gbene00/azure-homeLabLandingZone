output "allowed_locations" {
  description = "Azure regions allowed by governance policy"
  value       = local.allowed_locations
}

output "required_tags" {
  description = "Tags required on all resources"
  value       = local.required_tags
}

output "budget_ids" {
  description = "Created subscription budget ids."
  value       = module.subscription_budgets.budget_ids
}
