# Landing Zone – Corp

The corp landing zone is intended for **internal, private workloads**.

---

## Purpose

This landing zone provides a secure and isolated environment for internal applications and platforms.

---

## Responsibilities

- Define corp-specific resource groups
- Create a spoke virtual network
- Configure subnets for applications, AKS, and databases
- Establish hub-to-spoke connectivity
- Host internal workloads

---

## Current workloads

- Azure Kubernetes Service (AKS)

---

## Potential future workloads

This landing zone can be extended to support:
- Virtual machines
- VM Scale Sets
- Azure Container Apps
- Internal App Services
- Databases accessed via private endpoints
- Internal APIs and microservices

---

## Networking model

- Hub-and-spoke topology
- No direct internet exposure by default
- Controlled outbound access through platform NAT Gateway

---

## Design considerations

- Workload resources are fully isolated from other landing zones
- New services can be added without changing the core structure
- Security controls evolve incrementally
