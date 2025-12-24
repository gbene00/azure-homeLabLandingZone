# Landing Zone – Corp

The corp landing zone represents **internal or corporate workloads**.

## Scope

This layer defines an isolated workload environment connected to the platform hub.

### Resources typically managed here

- Corp-specific resource groups
- Spoke virtual network
- Subnets for applications, AKS, and data
- Network security controls
- Hub-to-spoke VNet peering

## Intended workload types

- Internal applications
- AKS clusters
- Databases
- Virtual machines

## Dependency model

- Requires governance layer
- Requires platform layer (hub networking)
