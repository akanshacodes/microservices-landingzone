variable "clusters" {
  description = "Map of AKS clusters to create"
  type = map(object({
    resource_group_name = string
    location            = string
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
      type                = optional(string, "VirtualMachineScaleSets")
      vnet_subnet_id      = optional(string)
    })

    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }), { type = "SystemAssigned" })

    network_profile = optional(object({
      network_plugin    = optional(string, "azure")
      load_balancer_sku = optional(string, "standard")
      service_cidr      = optional(string)
      dns_service_ip    = optional(string)
      docker_bridge_cidr = optional(string)
    }))
  }))
}
