# Platform Layer

The platform layer deploys **shared Azure services** that support all landing zones.

---

## Purpose

This layer provides the foundational infrastructure required by workloads, without being tied to any specific application.

---

## Responsibilities

- Create shared platform resource groups
- Deploy centralized logging and monitoring
- Build the hub virtual network
- Provide outbound connectivity via NAT Gateway
- Expose shared services to landing zones

---

## Resources managed

- Platform resource groups
- Log Analytics workspace
- Azure Monitor action groups
- Hub virtual network and subnets
- NAT Gateway and associations

---

## Design considerations

- Platform resources are long-lived and stable
- No workload-specific resources are deployed here
- Outputs are consumed by landing zones via remote state

---

## Dependency model

- Depends on the governance layer
- Must be deployed before any landing zone