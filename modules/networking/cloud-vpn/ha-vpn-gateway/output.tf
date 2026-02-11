output "vpn_gateway_name" {
  value = { for k, v in google_compute_ha_vpn_gateway.ha_vpn_gateways : k => v.name }
}