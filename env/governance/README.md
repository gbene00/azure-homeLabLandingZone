# Governance Layer

The governance layer defines **subscription-level guardrails** for the Azure Landing Zone.

## Scope

This layer is responsible for enforcing global rules that apply to all resources in the subscription.

### Resources typically managed here

- Azure Policy definitions
- Azure Policy initiatives (policy sets)
- Policy assignments at **subscription scope**
- RBAC role assignments at **subscription scope**

## Examples of governance controls

- Required resource tags
- Allowed Azure regions
- Cost and compliance baselines
- Separation of duties via RBAC

## Deployment responsibility

This layer must be deployed **before all others**, as it establishes the rules under which the rest of the environment operates.
