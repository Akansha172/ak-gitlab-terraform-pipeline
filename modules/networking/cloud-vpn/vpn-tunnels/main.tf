#################
#  VPN Tunnels  #
#################
resource "google_compute_vpn_tunnel" "vpn_tunnels" {
  for_each = var.vpn_tunnels

  name          = each.value.name
  shared_secret = each.value.shared_secret

  description = each.value.description

  # Use classic VPN gateway if defined
  target_vpn_gateway = each.value.target_vpn_gateway != null ? each.value.target_vpn_gateway : null

  # Use HA VPN gateway and interface if defined
  vpn_gateway           = each.value.vpn_gateway != null ? each.value.vpn_gateway : null
  vpn_gateway_interface = each.value.vpn_gateway_interface != null ? each.value.vpn_gateway_interface : null

  # Peer configuration
  peer_external_gateway           = each.value.peer_external_gateway
  peer_external_gateway_interface = each.value.peer_external_gateway_interface
  peer_gcp_gateway                = each.value.peer_gcp_gateway
  peer_ip                         = each.value.peer_ip

  # Routing and selectors
  router                  = each.value.router
  ike_version             = each.value.ike_version
  local_traffic_selector  = each.value.local_traffic_selector
  remote_traffic_selector = each.value.remote_traffic_selector

  labels  = each.value.labels
  region  = each.value.region
  project = each.value.project
}
