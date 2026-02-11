/* Optional to print keys
output "interconnect_pairing_keys" {
  description = "Pairing keys for interconnect attachments"
  value       = module.cloud_interconnect_attachment.interconnect_pairing_keys
}
*/

output "interconnect_self_links" {
  description = "Self link for interconnect attachments"
  value       = module.cloud_interconnect_attachment.interconnect_self_links
}

output "router_interfaces_self_links" {
  description = "Self links of created router interfaces"
  value       = module.router_interfaces.router_interfaces
}

output "router_peers_self_links" {
  description = "Self links of created router peers"
  value       = module.router_peers.router_peers
}

output "vpn_gateway_self_links" {
  description = "Self links of external vpn gateways"
  value       = module.external_vpn_gateways.external_vpn_gateway_self_links
}