#########
#  VPC  #
#########
resource "google_compute_network" "network" {
  for_each = var.vpc

  name                            = each.key
  routing_mode                    = each.value.routing_mode
  project                         = var.project_id
  auto_create_subnetworks         = each.value.auto_create_subnetworks
  delete_default_routes_on_create = each.value.delete_default_routes_on_create
}