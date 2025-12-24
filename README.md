# Azure Landing Zone – Homelab (Terraform)

This repository implements an **Azure Landing Zone–style architecture** using **Terraform** and a **single Azure subscription**.

The project follows Azure Landing Zone principles (governance, platform, landing zones, separation of concerns) while adapting them to a homelab scenario by:
- using **resource groups instead of subscriptions** for isolation
- keeping **costs low**
- deploying **incrementally by phase**

The design is intentionally modular and layered to reflect how enterprise Azure environments are structured, even though everything runs in a single subscription.

## High-level architecture

- **Governance**  
  Subscription-wide guardrails such as policies and RBAC.

- **Platform**  
  Shared services used by all workloads (logging, monitoring, hub networking).

- **Landing Zones**  
  Isolated workload environments (corp, online) implemented as spoke networks.

Each layer is deployed independently using its own Terraform state file.

## Key design decisions

- Single Azure subscription
- Multiple Terraform roots (one per layer)
- Separate remote state per layer
- Hub-and-spoke networking
- NAT Gateway for outbound connectivity
- Centralized logging
- Azure CLI authentication for local runs (CI/CD added later)

This repository is intended as:
- a learning platform
- a realistic Azure reference architecture
- a foundation for experimentation with Azure governance, networking, and workloads
