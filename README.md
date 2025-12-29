# Azure Landing Zone – Homelab (Terraform)

## Overview

This repository contains the infrastructure-as-code for a **single-subscription Azure Landing Zone homelab**, built using **Terraform**.

The goal is to model a **realistic Azure enterprise foundation**—including governance, platform services, and workload landing zones—while keeping the environment approachable, cost-aware, and suitable for experimentation.

Although this is a personal learning project, the repository structure and design decisions closely follow **Azure Landing Zone** and **platform engineering best practices**, making it suitable as a real-world reference.

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
- Experiment with **platform engineering concepts**, such as:
  - Separation of governance, platform, and workloads
  - Incremental infrastructure delivery
  - Infrastructure lifecycle management (deploy, evolve, destroy)

The repository intentionally mirrors how enterprise Azure environments are structured—even though everything runs in a single subscription.

---

## What This Repository Does

At a high level, this repository defines a **layered Azure Landing Zone architecture**, fully deployed in Microsoft Azure.

Terraform in this repository is responsible for:

- Establishing **subscription-level governance**
- Deploying **shared platform services**
- Creating **isolated workload landing zones**
- Providing a foundation for **Kubernetes and future workloads**
- Enforcing consistent **naming, tagging, and structure** across all resources

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
  - **Online** – internet-facing workloads

---

## Repository Structure

### Environment Roots

Each environment is a standalone Terraform root with its own state:

- `env/governance` – subscription-level controls
- `env/platform` – shared services and networking
- `env/landingzones/corp` – internal workloads
- `env/landingzones/online` – public workloads

### Reusable Modules

The `modules/` directory contains self-contained Terraform modules for:

- Resource groups
- Networking (hub and spoke)
- Logging and monitoring
- Azure Policy baselines
- RBAC assignments
- AKS clusters
- Budgets and cost controls

Each module is designed to be:

- Reusable
- Extensible
- Configurable via **maps and lists**
- Safe to evolve over time

---

## Infrastructure Lifecycle

This repository supports a **clean and repeatable infrastructure lifecycle**.

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
