#############################
#  PRIVATE SERVICE ACCESS  #
#############################
resource "google_compute_global_address" "global_address" {
  for_each = var.global_address

  project       = var.project_id
  network       = each.value.vpc_name
  name          = each.key
  address       = each.value.ipv4_address
  address_type  = each.value.address_type
  purpose       = each.value.purpose
  prefix_length = each.value.prefix_length
}

resource "google_service_networking_connection" "private_vpc_connection" {
  for_each = var.global_address

  network = each.value.vpc_name
  service = each.value.service
  //project               = var.project_id
  reserved_peering_ranges = [google_compute_global_address.global_address[each.key].name]
}

