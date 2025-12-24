# Policy Baseline Module

Defines and assigns Azure Policy objects that form the governance baseline.

## Resources created

- `azurerm_policy_definition`
- `azurerm_policy_set_definition` (optional)
- `azurerm_policy_assignment`

## Scope

Policies are typically assigned at:
- subscription scope

## Example use cases

- Require specific resource tags
- Restrict allowed Azure regions
- Enforce security and compliance standards
