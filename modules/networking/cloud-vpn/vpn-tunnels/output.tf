output "vpn_tunnel_ids" {
  description = "IDs of all created VPN tunnels"
  value = {
    for k, v in google_compute_vpn_tunnel.vpn_tunnels :
    k => v.id
  }
}
