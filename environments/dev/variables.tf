variable "resource_groups" {
  description = "Map of resource groups"
  type = map(object({
    location = string
    tags     = optional(map(string), {})
  }))
}

variable "registries" {
  description = "Map of ACRs"
  type = map(object({
    resource_group_key  = string
    sku                 = optional(string, "Standard")
    admin_enabled       = optional(bool, false)
    tags                = optional(map(string), {})
    network_rule_set = optional(object({
      default_action = optional(string, "Allow")
      ip_rules = optional(list(object({
        action   = string
        ip_range = string
      })), [])
    }))
  }))
}

variable "clusters" {
  description = "Map of AKS clusters"
  type = map(object({
    resource_group_key  = string
    dns_prefix          = string
    kubernetes_version  = optional(string)
    sku_tier            = optional(string, "Free")
    tags                = optional(map(string), {})
    
    default_node_pool = object({
      name                = string
      node_count          = optional(number, 1)
      vm_size             = optional(string, "Standard_DS2_v2")
      enable_auto_scaling = optional(bool, false)
      min_count           = optional(number)
      max_count           = optional(number)
    })
  }))
}
