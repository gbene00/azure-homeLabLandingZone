# Azure Landing Zone – Homelab (Terraform)

## Overview

This repository contains the infrastructure-as-code for a **single-subscription Azure Landing Zone homelab**, built using **Terraform** and **GitHub Actions**.

The goal is to model a **realistic Azure enterprise foundation**—including governance, platform services, workload landing zones, and delivery pipelines—while keeping the environment approachable, cost-aware, and suitable for experimentation.

Although this is a personal learning project, the repository structure and design decisions closely follow **Azure Landing Zone**, **platform engineering**, and **cloud governance best practices**, making it suitable as a real-world reference.

---

## Objectives

This homelab helps me:

- Practice **Azure Landing Zone architecture** in a controlled, low-risk environment
- Design **governance-first cloud foundations** using Azure Policy and RBAC
- Build a **hub-and-spoke networking model** with shared platform services
- Gain hands-on experience with **Terraform at scale**, including:
  - Multiple Terraform roots
  - Remote state separation
  - Reusable, composable modules
- Apply **platform engineering principles**, such as:
  - Separation of governance, platform, and workloads
  - Clear ownership boundaries (infra vs delivery)
  - Infrastructure lifecycle management (deploy, evolve, destroy)
- Implement **realistic CI/CD workflows** using GitHub Actions and Azure OIDC

The repository intentionally mirrors how enterprise Azure environments are structured—even though everything runs in a single subscription.

---

## What This Repository Does

At a high level, this repository defines and deploys a **layered Azure Landing Zone architecture**, fully implemented in Microsoft Azure.

Terraform in this repository is responsible for:

- Establishing **subscription-level governance**
- Deploying **shared platform services**
- Creating **isolated workload landing zones**
- Providing a foundation for **Kubernetes and future workloads**
- Enforcing consistent **naming, tagging, and structure** across all resources

GitHub Actions is responsible for:

- Infrastructure deployment orchestration
- Environment-specific automation
- Static content delivery for internet-facing workloads

Each layer is deployed independently, using its own Terraform state, while respecting clear dependency boundaries.

---

## High-Level Architecture

The environment is organized into **three main layers**:

### Governance
- Subscription-level Azure Policies
- Tagging and location guardrails
- Baseline compliance controls

### Platform
- Shared resource groups
- Centralized logging and monitoring
- Hub virtual network
- Outbound connectivity via NAT Gateway

### Landing Zones
- Workload isolation using spoke networks
- Separate environments for different workload types:
  - **Corp** – internal workloads (e.g. AKS)
  - **Online** – internet-facing workloads (static website)

---

## Repository Structure

### Environment Roots

Each environment is a standalone Terraform root with its own state:

- `env/governance` – subscription-level controls
- `env/platform` – shared services and hub networking
- `env/landingzones/corp` – internal workloads
- `env/landingzones/online` – public workloads and static website hosting

### Reusable Modules

The `modules/` directory contains self-contained Terraform modules for:

- **resource-group** – standardized resource group creation
- **hub-network** – hub virtual network and NAT Gateway
- **spoke-network** – landing zone virtual networks and NSGs
- **logging** – Log Analytics and alerting
- **policy-baseline** – subscription-level Azure Policy assignments
- **policy-baseline-rg** – resource-group scoped policies
- **aks** – Azure Kubernetes Service clusters
- **staticwebsite** – Azure Storage static website (infra only)
- **budgets** – Azure Cost Management budgets (optional)
- **rbac** – RBAC patterns (placeholder for future expansion)

Each module is designed to be:

- Reusable and composable
- Configurable via maps and objects
- Safe to evolve incrementally
- Aligned with enterprise Terraform patterns

---

## CI/CD Workflows

This repository uses **GitHub Actions with Azure OIDC authentication**, following least-privilege principles.

### Infrastructure workflows
- Separate workflows for:
  - Governance
  - Platform
  - Corp landing zone
  - Online landing zone
- Each workflow:
  - Runs Terraform plan + apply
  - Uses environment-scoped OIDC identities
  - Maintains independent Terraform state

### Content delivery workflow
- Static website content is deployed **without Terraform**
- Changes under `static-site-content/**` trigger a workflow that:
  - Authenticates using the **online landing zone OIDC identity**
  - Uploads content directly to the `$web` container
- This cleanly separates **infrastructure lifecycle** from **content lifecycle**

---

## Infrastructure Lifecycle

### Deployment Order

Infrastructure is deployed incrementally in the following order:

1. Governance
2. Platform
3. Landing Zones (corp, online)

This ensures all guardrails and shared services exist before workloads are introduced.

### Destruction Order

Resources are removed in the **reverse order**:

1. Landing Zones
2. Platform
3. Governance

This prevents dependency conflicts and enables clean teardown.
