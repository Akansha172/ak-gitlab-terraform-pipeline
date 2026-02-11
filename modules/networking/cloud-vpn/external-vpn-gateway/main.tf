###########################
#  External VPN Gateways  #
###########################
resource "google_compute_external_vpn_gateway" "external_vpn_gateways" {
  for_each = var.external_vpn_gateways

  name            = each.key
  description     = each.value.description
  labels          = each.value.labels
  redundancy_type = each.value.redundancy_type

  dynamic "interface" {
    for_each = each.value.interfaces
    content {
      id           = interface.value.id
      ip_address   = interface.value.ip_address
      ipv6_address = interface.value.ipv6_address
    }
  }

  project = each.value.project
}
