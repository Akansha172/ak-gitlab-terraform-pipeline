###########################
#  Interconnect Physical  #
###########################
resource "google_compute_interconnect" "cloud_interconnect" {
  for_each = var.interconnects

  name                 = each.value.name
  interconnect_type    = each.value.interconnect_type
  link_type            = each.value.link_type
  requested_link_count = each.value.requested_link_count
  location             = each.value.location
  description          = each.value.description
  customer_name        = each.value.customer_name
  noc_contact_email    = each.value.noc_contact_email
}
