output "resource_group_names" {
  description = "Names of the created resource groups"
  value       = { for k, v in azurerm_resource_group.rg : k => v.name }
}

output "resource_group_locations" {
  description = "Locations of the created resource groups"
  value       = { for k, v in azurerm_resource_group.rg : k => v.location }
}
