resource_groups = {
  "rg-microservices-dev" = {
    location = "East US"
    tags = {
      environment = "dev"
      managed_by  = "terraform"
    }
  }
}

registries = {
  "acrmicrodev001" = {
    resource_group_key = "rg-microservices-dev"
    sku                = "Premium"
    admin_enabled      = true
    network_rule_set = {
      default_action = "Deny"
      ip_rules = [
        {
          action   = "Allow"
          ip_range = "1.2.3.4/32"
        }
      ]
    }
  }
}

clusters = {
  "aks-micro-dev-001" = {
    resource_group_key = "rg-microservices-dev"
    dns_prefix         = "aksmicrodev"
    sku_tier           = "Free"
    default_node_pool = {
      name       = "default"
      node_count = 1
      vm_size    = "Standard_DS2_v2"
    }
  }
}
