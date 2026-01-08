# Static Website Module

This module deploys the **infrastructure required for an Azure Storage static website**.

---

## Purpose

Provides a simple, low-cost, and reliable platform for hosting static web content as part of an internet-facing landing zone.

The module is intentionally limited to **infrastructure concerns only**.

---

## Resources created

- Azure Storage Account
- Static website configuration (`$web` container enabled)
- Optional Azure CDN resources (if enabled)

---

## What this module does NOT do

This module **does not**:

- Upload website content
- Manage HTML, CSS, or assets
- Handle content lifecycle or deployment pipelines

Content delivery is handled separately via **GitHub Actions**, keeping a clean separation between infrastructure and delivery.

---

## Design principles

- Infrastructure-only responsibility
- Compatible with CI/CD-based content delivery
---

## Typical usage

Used by:
- `env/landingzones/online`

Content is uploaded to the `$web` container by an external workflow after infrastructure provisioning.

---

## Extensibility

Future enhancements may include:
- Azure CDN integration
- Custom domain support
- HTTPS and managed certificates
- Front Door or WAF integration
