output "network_self_links" {
  value = module.vpc.network_self_links
}

output "subnetwork_self_links" {
  value = module.subnets.subnetwork_self_links
}