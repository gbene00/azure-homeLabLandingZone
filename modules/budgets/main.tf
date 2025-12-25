## Azure Budgets Subscription Module
resource "azurerm_consumption_budget_subscription" "budget_subscription" {
  for_each = var.budgets

  name            = each.value.name
  subscription_id = var.subscription_id

  amount     = each.value.amount
  time_grain = each.value.time_grain

  time_period {
    start_date = each.value.start_date
    end_date   = try(each.value.end_date, null)
  }

## Budget Notifications
  dynamic "notification" {
    for_each = each.value.notifications
    content {
      enabled        = notification.value.enabled
      operator       = notification.value.operator
      threshold      = notification.value.threshold
      contact_emails = notification.value.contact_emails
    }
  }
}