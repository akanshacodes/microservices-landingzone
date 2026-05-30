output "resource_group_names" {
  value = module.resource_groups.resource_group_names
}

output "acr_login_servers" {
  value = module.acr.acr_login_servers
}

output "aks_fqdns" {
  value = module.aks.aks_fqdns
}
