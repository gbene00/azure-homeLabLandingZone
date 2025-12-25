output "log_analytics_workspace_id" {
  value       = module.platform_logging.log_analytics_workspace_id
  description = "Log Analytics Workspace ID."
}

output "action_group_ids" {
  value       = module.platform_logging.action_group_ids
  description = "Action group IDs."
}

output "platform_management_rg_name" {
  value       = module.platform_management_rg.name
  description = "Platform management resource group name."
}
