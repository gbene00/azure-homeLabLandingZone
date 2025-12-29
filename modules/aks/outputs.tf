output "aks_id" {
  value = azurerm_kubernetes_cluster.aks_cluster.id
}

output "aks_name" {
  value = azurerm_kubernetes_cluster.aks_cluster.name
}

output "kube_config" {
  description = "Kubeconfig file content to access the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
  sensitive   = true
}
