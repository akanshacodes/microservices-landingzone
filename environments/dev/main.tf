module "resource_groups" {
  source = "../../modules/resource_group"

  resource_groups = var.resource_groups
}

module "acr" {
  source = "../../modules/acr"

  registries = {
    for k, v in var.registries : k => {
      resource_group_name = module.resource_groups.resource_group_names[v.resource_group_key]
      location            = module.resource_groups.resource_group_locations[v.resource_group_key]
      sku                 = v.sku
      admin_enabled       = v.admin_enabled
      tags                = v.tags
      network_rule_set    = v.network_rule_set
    }
  }

  depends_on = [module.resource_groups]
}

module "aks" {
  source = "../../modules/aks"

  clusters = {
    for k, v in var.clusters : k => {
      resource_group_name = module.resource_groups.resource_group_names[v.resource_group_key]
      location            = module.resource_groups.resource_group_locations[v.resource_group_key]
      dns_prefix          = v.dns_prefix
      kubernetes_version  = v.kubernetes_version
      sku_tier            = v.sku_tier
      tags                = v.tags
      default_node_pool   = v.default_node_pool
    }
  }

  depends_on = [module.resource_groups]
}
