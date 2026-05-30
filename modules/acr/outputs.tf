output "acr_ids" {
  description = "IDs of the created ACRs"
  value       = { for k, v in azurerm_container_registry.acr : k => v.id }
}

output "acr_login_servers" {
  description = "Login servers of the created ACRs"
  value       = { for k, v in azurerm_container_registry.acr : k => v.login_server }
}
