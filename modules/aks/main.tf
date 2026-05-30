resource "azurerm_kubernetes_cluster" "aks" {
  for_each = var.clusters

  name                = each.key
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  dns_prefix          = each.value.dns_prefix
  kubernetes_version  = each.value.kubernetes_version
  sku_tier            = each.value.sku_tier
  tags                = each.value.tags

  default_node_pool {
    name                = each.value.default_node_pool.name
    node_count          = each.value.default_node_pool.node_count
    vm_size             = each.value.default_node_pool.vm_size
    enable_auto_scaling = each.value.default_node_pool.enable_auto_scaling
    min_count           = each.value.default_node_pool.min_count
    max_count           = each.value.default_node_pool.max_count
    type                = each.value.default_node_pool.type
    vnet_subnet_id      = each.value.default_node_pool.vnet_subnet_id
  }

  dynamic "identity" {
    for_each = each.value.identity != null ? [each.value.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "network_profile" {
    for_each = each.value.network_profile != null ? [each.value.network_profile] : []
    content {
      network_plugin     = network_profile.value.network_plugin
      load_balancer_sku  = network_profile.value.load_balancer_sku
      service_cidr       = network_profile.value.service_cidr
      dns_service_ip     = network_profile.value.dns_service_ip
      docker_bridge_cidr = network_profile.value.docker_bridge_cidr
    }
  }
}
