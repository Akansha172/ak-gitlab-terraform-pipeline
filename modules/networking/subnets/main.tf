############
#  Subnet  #
############
resource "google_compute_subnetwork" "subnetwork" {

  for_each                 = var.subnets
  name                     = each.key
  ip_cidr_range            = each.value.subnet_ip
  region                   = each.value.subnet_region
  private_ip_google_access = each.value.subnet_private_access
  network                  = each.value.network_name
  project                  = var.project_id
  description              = lookup(each.value, "description", null)
  # dynamic "secondary_ip_range" {
  #   for_each = contains(keys(var.secondary_ranges), each.value.subnet_name) == true ? var.secondary_ranges[each.value.subnet_name] : []
  #       content {
  #       range_name    = secondary_ip_range.value.range_name
  #       ip_cidr_range = secondary_ip_range.value.ip_cidr_range
  #   }
  # }
  dynamic "secondary_ip_range" {
    # Only create secondary IP ranges if the subnet exists in var.secondary_ranges
    for_each = contains(keys(var.secondary_ranges), each.key) ? var.secondary_ranges[each.key] : []
    content {
      range_name    = secondary_ip_range.value.range_name
      ip_cidr_range = secondary_ip_range.value.ip_cidr_range
    }
  }
}