output "storage_account_id" {
  description = "Static website storage account id."
  value       = var.enabled ? azurerm_storage_account.static_site[0].id : null
}

output "primary_web_endpoint" {
  description = "Storage static website endpoint (direct)."
  value       = var.enabled ? azurerm_storage_account.static_site[0].primary_web_endpoint : null
}

output "cdn_endpoint_hostname" {
  description = "CDN endpoint hostname."
  value       = (var.enabled && try(var.cdn.enabled, false)) ? azurerm_cdn_endpoint.cdn_endpoint[0].fqdn : null
}

output "storage_account_name" {
  description = "Storage account name for the static website."
  value       = var.enabled ? azurerm_storage_account.static_site[0].name : null
}

output "storage_account_primary_access_key" {
  description = "Primary access key (used for uploads)."
  value       = var.enabled ? azurerm_storage_account.static_site[0].primary_access_key : null
  sensitive   = true
}
