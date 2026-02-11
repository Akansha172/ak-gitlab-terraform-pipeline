###############
#  Cloud NAT  # 
###############
resource "google_compute_router_nat" "nat" {
  for_each = var.cloud_nat

  name                               = each.key
  project                            = var.project_id
  router                             = each.value.router_name
  region                             = each.value.region
  nat_ip_allocate_option             = each.value.nat_ip_allocate_option
  source_subnetwork_ip_ranges_to_nat = each.value.source_subnetwork_ip_ranges_to_nat

}
