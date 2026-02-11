output "external_vpn_gateway_self_links" {
  description = "Self links of the created external VPN gateways"
  value = {
    for k, v in google_compute_external_vpn_gateway.external_vpn_gateways :
    k => v.self_link
  }
}