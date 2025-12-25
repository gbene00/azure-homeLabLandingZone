## Azure Subscription ID
variable "subscription_id" {
  description = "The subscription ID for a subscription-scope budget."
  type        = string
}

## Azure Budgets Configuration
variable "budgets" {
  description = "Map of budgets to create. Key is an internal identifier."
  type = map(object({
    name            = string
    amount          = number
    time_grain      = optional(string, "Monthly") 
    start_date      = string                      # YYYY-MM-DD
    end_date        = optional(string)            # YYYY-MM-DD 

    notifications = map(object({
      enabled        = bool
      operator       = string                     
      threshold      = number                     # percentage value
      contact_emails = list(string)
    }))
  }))
}