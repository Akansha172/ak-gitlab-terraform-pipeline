##################
#  Router Peers  #
##################
resource "google_compute_router_peer" "router_peers" {
  for_each = var.router_peers

  name                      = each.key
  interface                 = each.value.interface
  peer_asn                  = each.value.peer_asn
  router                    = each.value.router
  region                    = each.value.region
  project                   = var.project_id
  ip_address                = each.value.ip_address
  peer_ip_address           = each.value.peer_ip_address
  advertised_route_priority = each.value.advertised_route_priority
  advertise_mode            = each.value.advertise_mode
  advertised_groups         = each.value.advertise_mode == "CUSTOM" ? each.value.advertised_groups : null

  dynamic "advertised_ip_ranges" {
    for_each = each.value.advertised_ip_ranges
    content {
      range       = advertised_ip_ranges.value.range
      description = advertised_ip_ranges.value.description
    }
  }

  dynamic "custom_learned_ip_ranges" {
    for_each = each.value.custom_learned_ip_ranges
    content {
      range = custom_learned_ip_ranges.value.range
    }
  }

  custom_learned_route_priority      = each.value.zero_custom_learned_route_priority == true ? 0 : each.value.custom_learned_route_priority
  zero_custom_learned_route_priority = each.value.zero_custom_learned_route_priority

  dynamic "bfd" {
    for_each = each.value.bfd != null ? [each.value.bfd] : []
    content {
      session_initialization_mode = bfd.value.session_initialization_mode
      min_transmit_interval       = bfd.value.min_transmit_interval
      min_receive_interval        = bfd.value.min_receive_interval
      multiplier                  = bfd.value.multiplier
    }
  }

  dynamic "md5_authentication_key" {
    for_each = each.value.md5_authentication_key != null ? [each.value.md5_authentication_key] : []
    content {
      name = md5_authentication_key.value.name
      key  = md5_authentication_key.value.key
    }
  }

  enable      = each.value.enable
  enable_ipv6 = each.value.enable_ipv6
  enable_ipv4 = each.value.enable_ipv4

  ipv6_nexthop_address      = each.value.ipv6_nexthop_address
  ipv4_nexthop_address      = each.value.ipv4_nexthop_address
  peer_ipv6_nexthop_address = each.value.peer_ipv6_nexthop_address
  peer_ipv4_nexthop_address = each.value.peer_ipv4_nexthop_address

  router_appliance_instance = each.value.router_appliance_instance

  import_policies = each.value.import_policies
  export_policies = each.value.export_policies
}
