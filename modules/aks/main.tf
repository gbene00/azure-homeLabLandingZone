## AKS Cluster
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = coalesce(var.dns_prefix, var.name)

  kubernetes_version = var.kubernetes_version

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
  name                = var.node_pool.name
  vm_size             = var.node_pool.vm_size
  os_disk_size_gb     = var.node_pool.os_disk_size_gb
  vnet_subnet_id      = var.subnet_id
  type                = "VirtualMachineScaleSets"

  node_count = (
    var.node_pool.min_count != null && var.node_pool.max_count != null
  ) ? null : var.node_pool.node_count

  min_count = var.node_pool.min_count
  max_count = var.node_pool.max_count
}
  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }

  tags = var.tags
}
