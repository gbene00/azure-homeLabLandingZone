## Azure Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = var.log_analytics.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku               = try(var.log_analytics.sku, "PerGB2018")
  retention_in_days = var.log_analytics.retention_days

  tags = var.tags
}

## Azure Monitor Action Groups
resource "azurerm_monitor_action_group" "action_group" {
  for_each            = var.action_groups

  name                = each.value.name
  resource_group_name = var.resource_group_name
  short_name          = each.value.short_name

  dynamic "email_receiver" {
    for_each = each.value.email_receivers
    content {
      name          = email_receiver.value.name
      email_address = email_receiver.value.email
    }
  }

  tags = var.tags
}
