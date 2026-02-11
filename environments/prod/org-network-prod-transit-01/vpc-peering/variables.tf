##################
#  VPC peerings  # 
##################
variable "peerings" {
  description = "Map of VPC peerings to create"
  type = map(object({
    name                                = string                        # (Required) Name of the peering
    network                             = string                        # (Required) Primary network of the peering
    peer_network                        = string                        # (Required) Peer network in the peering
    export_custom_routes                = optional(bool, false)         # (Optional) Export custom routes to peer
    import_custom_routes                = optional(bool, false)         # (Optional) Import custom routes from peer
    export_subnet_routes_with_public_ip = optional(bool, true)          # (Optional) Export subnet routes with public IPs
    import_subnet_routes_with_public_ip = optional(bool, false)         # (Optional) Import subnet routes with public IPs
    stack_type                          = optional(string, "IPV4_ONLY") # (Optional) Type of IP traffic (IPV4_ONLY/IPV4_IPV6)
  }))
  default = {}
}
