# Landing Zone – Online

The **online landing zone** is designed for **internet-facing workloads**, with a focus on clean separation between infrastructure and delivery.

---

## Purpose

This landing zone provides a controlled environment for publicly accessible services while maintaining isolation from internal systems and shared platform resources.

It currently hosts a **static website** that serves as a personal Azure Landing Zone portal.

---

## Responsibilities

- Define online-specific resource groups
- Create a spoke virtual network
- Configure subnets for public-facing services
- Apply network security controls (NSGs)
- Establish hub-to-spoke connectivity
- Provide infrastructure for internet-facing workloads

---

## Current workloads

- **Static Website**
  - Hosted on Azure Storage static website
  - Content delivered via GitHub Actions
  - Infrastructure managed via Terraform

---

## Networking model

- Hub-and-spoke topology
- Dedicated spoke VNet for online workloads
- NSG-protected subnets
- Connectivity to shared platform services via hub peering
- Outbound traffic routed through platform NAT Gateway

---

## Design considerations

- Infrastructure and content lifecycles are **intentionally decoupled**
- Terraform manages **resources only**
- GitHub Actions manages **content delivery**
- The landing zone is optional and can be removed independently
- Security posture can be enhanced incrementally

---

## Future evolution (not yet implemented)

This landing zone is designed to support:

- Azure CDN or Front Door
- Custom domains and HTTPS 
- WAF and edge security controls
- Public APIs and edge-facing services
- Additional public workload patterns
