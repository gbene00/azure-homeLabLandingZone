output "log_analytics_workspace_id" {
  description = "Log Analytics Workspace resource ID."
  value       = azurerm_log_analytics_workspace.log_analytics_workspace.id
}

output "log_analytics_workspace_name" {
  description = "Log Analytics Workspace name."
  value       = azurerm_log_analytics_workspace.log_analytics_workspace.name
}

output "action_group_ids" {
  description = "Map of Action Group IDs keyed by action_groups map key. Loop over each created action group instance"
  value       = { for k, v in azurerm_monitor_action_group.action_group : k => v.id }
}
