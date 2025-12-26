output "allowed_locations" {
  description = "Azure regions allowed by governance policy."
  value       = local.allowed_locations
}

output "required_tags" {
  description = "Tags required by governance policy."
  value       = local.required_tags
}

output "policy_allowed_locations_assignment_id" {
  description = "Policy assignment ID for allowed locations."
  value       = module.policy_allowed_locations.policy_assignment_id
}

output "policy_require_tags_assignment_ids" {
  description = "Map of required-tag policy assignment IDs keyed by tag name."
  value       = { for k, m in module.policy_require_tags : k => m.policy_assignment_id }
}
