## Azure Policy Baseline
variable "name" {
  description = "Policy assignment name."
  type        = string
}

## Azure Policy Description
variable "description" {
  description = "Policy assignment description."
  type        = string
  default     = ""
}

## Azure Policy Type
variable "policy_type" {
  description = "Baseline policy type. Supported: allowed_locations, require_tag_on_resources"
  type        = string
}

## Azure Policy Assignment Scope
variable "assignment_scope" {
  description = "Scope at which to assign the policy (e.g., subscription resource ID)."
  type        = string
}

## Azure Policy Assignment Parameters
variable "parameters" {
  description = "Policy assignment parameters object (will be jsonencoded)."
  type        = any
  default     = {}
}

## Azure Policy Enforcement Mode
variable "enforcement_mode" {
  description = "Policy enforcement mode. Default: Default. Use 'DoNotEnforce' for testing."
  type        = string
  default     = "Default"
}
