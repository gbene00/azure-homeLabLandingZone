# Azure Landing Zone – Homelab (Terraform)

This repository implements an **Azure Landing Zone–style architecture** using **Terraform** within a **single Azure subscription**.

The project follows core Azure Landing Zone principles—governance, platform foundation, workload isolation, and separation of concerns—while adapting them to a homelab scenario by:
- using **resource groups instead of subscriptions** for isolation
- keeping **costs low**
- deploying the environment **incrementally by layer**

The design is intentionally modular and layered to reflect how enterprise Azure environments are structured, even though all resources reside in one subscription.

---

## Architecture overview

The environment is structured into independent layers, each managed by its own Terraform root and state file.

### Governance
Defines subscription-wide guardrails such as policies and baseline compliance controls.

### Platform
Provides shared services used by all workloads, including networking, monitoring, and outbound connectivity.

### Landing Zones
Isolated workload environments implemented as spoke networks:
- **Corp** – internal workloads
- **Online** – internet-facing workloads

Each layer is deployed and managed independently, but follows a clear dependency order.

---

## Key design principles

- Single Azure subscription
- Multiple Terraform roots (one per layer)
- Separate remote state per layer
- Hub-and-spoke networking model
- Centralized logging and monitoring
- NAT Gateway for controlled outbound access
- Variables modeled as maps and lists for extensibility

---

## Intended use

This repository serves as:
- a learning platform for Azure Landing Zones
- a realistic reference architecture
- a foundation for experimenting with governance, networking, and workloads
- a base for future CI/CD automation

---

## Deployment order

Infrastructure must be deployed in the following logical sequence:

1. **Governance**  
   Establishes global rules and guardrails that apply to all resources.

2. **Platform**  
   Deploys shared services such as networking and monitoring that landing zones depend on.

3. **Landing Zones**  
   Workload environments (corp, online) that consume platform services.

This order ensures all dependencies are satisfied before workloads are introduced.

---

## Resource destruction order

To safely remove the environment, resources should be destroyed in the **reverse order** of deployment:

1. **Landing Zones**  
   All workload resources must be removed first.

2. **Platform**  
   Shared services are removed after workloads no longer depend on them.

3. **Governance**  
   Policies and global controls are removed last.

This approach avoids dependency conflicts and ensures clean teardown.
