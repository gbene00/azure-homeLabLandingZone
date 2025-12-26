## Azure Policy Baseline Name
variable "name" {
  description = "Policy assignment name."
  type        = string
}

## Azure Policy Baseline Description
variable "description" {
  description = "Policy assignment description."
  type        = string
  default     = ""
}

## Azure Policy Baseline Type
variable "policy_type" {
  description = "Baseline policy type. Supported: allowed_locations, require_tag_on_resources"
  type        = string
}

## Azure Subscription ID
variable "subscription_id" {
  description = "Subscription ID where the policy will be assigned."
  type        = string
}

## Azure Policy Baseline Parameters
variable "parameters" {
  description = "Policy assignment parameters object (will be jsonencoded)."
  type        = any
  default     = {}
}
