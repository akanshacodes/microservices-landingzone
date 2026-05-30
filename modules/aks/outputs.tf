output "aks_ids" {
  description = "IDs of the created AKS clusters"
  value       = { for k, v in azurerm_kubernetes_cluster.aks : k => v.id }
}

output "aks_fqdns" {
  description = "FQDNs of the created AKS clusters"
  value       = { for k, v in azurerm_kubernetes_cluster.aks : k => v.fqdn }
}

output "aks_kube_configs" {
  description = "Kube configs of the created AKS clusters"
  value       = { for k, v in azurerm_kubernetes_cluster.aks : k => v.kube_config_raw }
  sensitive   = true
}
