output "subnetwork_self_links" {
  value = { for name, net in google_compute_subnetwork.subnetwork : name => net.self_link }
}