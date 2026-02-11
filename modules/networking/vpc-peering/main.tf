##################
#  VPC peerings  # 
##################
resource "google_compute_network_peering" "peerings" {
  for_each = var.peerings

  name         = each.value.name
  network      = each.value.network
  peer_network = each.value.peer_network

  export_custom_routes                = each.value.export_custom_routes
  import_custom_routes                = each.value.import_custom_routes
  export_subnet_routes_with_public_ip = each.value.export_subnet_routes_with_public_ip
  import_subnet_routes_with_public_ip = each.value.import_subnet_routes_with_public_ip
  stack_type                          = each.value.stack_type
}
