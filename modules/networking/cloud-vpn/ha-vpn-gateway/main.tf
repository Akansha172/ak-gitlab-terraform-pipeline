####################
#  HA VPN Gateways #
####################
resource "google_compute_ha_vpn_gateway" "ha_vpn_gateways" {
  for_each = var.ha_vpn_gateways

  name               = each.key
  network            = each.value.network
  description        = each.value.description
  region             = each.value.region
  project            = each.value.project
  stack_type         = each.value.stack_type
  gateway_ip_version = each.value.gateway_ip_version
  labels             = each.value.labels

  dynamic "vpn_interfaces" {
    for_each = each.value.vpn_interfaces
    content {
      id                      = lookup(vpn_interfaces.value, "id", null)
      interconnect_attachment = lookup(vpn_interfaces.value, "interconnect_attachment", null)
    }
  }
}
