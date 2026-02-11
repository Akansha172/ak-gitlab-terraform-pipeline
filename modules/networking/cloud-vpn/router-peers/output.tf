output "router_peers" {
  description = "Self links or IDs of created router peers"
  value = {
    for k, v in google_compute_router_peer.router_peers :
    k => v.id
  }
}