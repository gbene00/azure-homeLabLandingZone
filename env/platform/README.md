# Platform Layer

The platform layer deploys **shared Azure services** that support all landing zones.

## Scope

This layer provides foundational infrastructure that workloads depend on.

### Resources typically managed here

- Platform resource groups
- Centralized logging and monitoring
- Hub virtual network
- Outbound connectivity services
- Shared identity-related infrastructure

## Typical responsibilities

- Create the hub network used by all spokes
- Provide centralized Log Analytics
- Configure alerting and diagnostics sinks
- Enable shared services used by multiple landing zones

## Dependency model

- Depends on the governance layer
- Must be deployed before landing zones
