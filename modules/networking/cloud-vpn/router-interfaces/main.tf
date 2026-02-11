#######################
#  Router Interfaces  #
#######################
resource "google_compute_router_interface" "router_interfaces" {
  for_each = var.router_interfaces

  name                    = each.key
  router                  = each.value.router
  ip_range                = each.value.ip_range
  ip_version              = each.value.ip_version
  vpn_tunnel              = each.value.vpn_tunnel
  interconnect_attachment = each.value.interconnect_attachment
  subnetwork              = each.value.subnetwork
  redundant_interface     = each.value.redundant_interface
  private_ip_address      = each.value.private_ip_address
  project                 = each.value.project
  region                  = each.value.region
}

