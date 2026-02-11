###################
#  Cloud Routers  #
###################
resource "google_compute_router" "router" {
  for_each = var.routers

  name                          = each.key                                 # (Required) Name of the router
  project                       = var.project_id                           # (Optional) Use per-router project or fallback to default
  region                        = each.value.region                        # (Required) Region of the router
  network                       = each.value.network                       # (Required) Network to which the router is attached
  description                   = each.value.description                   # (Optional) Description for the router
  encrypted_interconnect_router = each.value.encrypted_interconnect_router # (Optional) If router is for encrypted VLAN attachments

  dynamic "md5_authentication_keys" {
    for_each = each.value.md5_authentication_keys
    content {
      name = md5_authentication_keys.value.name # (Required) Name of the MD5 key
      key  = md5_authentication_keys.value.key  # (Required) Value of the MD5 key
    }
  }

  dynamic "bgp" {
    for_each = each.value.bgp != null ? [each.value.bgp] : []
    content {
      asn                = bgp.value.asn                                                            # (Required) ASN for BGP sessions
      keepalive_interval = bgp.value.keepalive_interval != null ? bgp.value.keepalive_interval : 20 # (Optional) BGP keepalive interval
      advertise_mode     = bgp.value.advertise_mode                                                 # (Optional) Advertise mode: DEFAULT or CUSTOM
      advertised_groups  = bgp.value.advertised_groups                                              # (Optional) Prefix groups to advertise

      dynamic "advertised_ip_ranges" {
        for_each = bgp.value.advertised_ip_ranges
        content {
          range       = advertised_ip_ranges.value.range       # (Required) The CIDR IP range to advertise
          description = advertised_ip_ranges.value.description # (Optional) Description of the IP range
        }
      }
    }
  }
}
