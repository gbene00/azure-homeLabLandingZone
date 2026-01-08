## Azure Storage Account for Static Website
resource "azurerm_storage_account" "static_site" {
  count = var.enabled ? 1 : 0

  name                     = var.storage_account.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.storage_account.account_tier
  account_replication_type = var.storage_account.account_replication_type

  # For static websites, you typically want public blob access enabled
  allow_nested_items_to_be_public = true

  tags = var.tags
}

## Azure Storage Account Static Website Configuration
resource "azurerm_storage_account_static_website" "static_site" {
  count = var.enabled ? 1 : 0

  storage_account_id = azurerm_storage_account.static_site[0].id
  index_document     = var.storage_account.index_document
  error_404_document = var.storage_account.error_404_document
}

## Azure CDN Profile (not enabled for now)
resource "azurerm_cdn_profile" "cdn_profile" {
  count = (var.enabled && try(var.cdn.enabled, false)) ? 1 : 0

  name                = coalesce(var.cdn.profile_name, "${var.storage_account.name}-cdn-profile")
  location            = "global"
  resource_group_name = var.resource_group_name
  sku                 = "Standard_Microsoft"

  tags = var.tags
}

## Azure CDN Endpoint
resource "azurerm_cdn_endpoint" "cdn_endpoint" {
  count = (var.enabled && try(var.cdn.enabled, false)) ? 1 : 0

  name                = coalesce(var.cdn.endpoint_name, "${var.storage_account.name}-cdn-endpoint")
  profile_name        = azurerm_cdn_profile.cdn_profile[0].name
  location            = "global"
  resource_group_name = var.resource_group_name

  origin {
    name      = "storageorigin"
    host_name = replace(azurerm_storage_account.static_site[0].primary_web_host, "https://", "")
  }

  depends_on = [
    azurerm_storage_account.static_site
  ]
}
