output "network_self_links" {
  value = { for name, net in google_compute_network.network : name => net.self_link }
}