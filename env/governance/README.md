# Governance Layer

The governance layer defines **subscription-level guardrails** for the Azure Landing Zone.

---

## Purpose

This layer enforces global rules that apply across the entire Azure subscription, regardless of workload or environment.

---

## Responsibilities

- Define allowed Azure regions
- Enforce required resource tags
- Establish baseline compliance expectations
- Provide a foundation for cost and security governance

---

## Resources managed

- Azure Policy assignments at subscription scope
- Location restriction policies
- Tag governance policies

---

## Design considerations

- Governance is applied before any other layer
- Policies are intentionally simple and auditable
- Enforcement can be relaxed or scoped later if required
- Managed services may require exemptions or lower-scope policies

---

## Dependency model

This layer has **no dependencies** and must be deployed **before all others**.
