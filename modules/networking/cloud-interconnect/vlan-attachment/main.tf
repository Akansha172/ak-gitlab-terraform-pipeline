#########################
#  IP address for VLAN  #
#########################
resource "google_compute_address" "ip" {
  for_each = {
    for pair in flatten([
      for attachment_key, attachment in var.interconnect_attachments : [
        for ip in attachment.ip_configs : {
          key           = "${attachment_key}-${ip.name}"
          region        = attachment.region
          name          = ip.name
          address       = ip.address
          address_type  = ip.address_type
          purpose       = lookup(ip, "purpose", "IPSEC_INTERCONNECT")
          description   = lookup(ip, "description", null)
          network       = lookup(ip, "network", null)
          subnetwork    = lookup(ip, "subnetwork", null)
          network_tier  = lookup(ip, "network_tier", null)
          labels        = lookup(ip, "labels", {})
          prefix_length = lookup(ip, "prefix_length", null)
          ip_version    = lookup(ip, "ip_version", null)
        }
      ]
    ]) : pair.key => pair
  }

  name          = each.value.name
  region        = each.value.region
  address       = each.value.address
  address_type  = each.value.address_type
  purpose       = each.value.purpose
  description   = each.value.description
  labels        = each.value.labels
  prefix_length = each.value.prefix_length
  ip_version    = each.value.ip_version

  # Internal IPs require purpose + network and no network_tier
  network      = each.value.address_type == "INTERNAL" && contains(["IPSEC_INTERCONNECT", "VPC_PEERING"], each.value.purpose) ? each.value.network : null
  subnetwork   = each.value.address_type == "INTERNAL" && contains(["GCE_ENDPOINT", "DNS_RESOLVER"], each.value.purpose) ? each.value.subnetwork : null
  network_tier = each.value.address_type == "EXTERNAL" ? each.value.network_tier : null

  project = var.project_id
}


####################################
#  Interconnect Attachment (VLAN)  #
####################################
resource "google_compute_interconnect_attachment" "attachment" {
  for_each = var.interconnect_attachments

  name                     = each.key
  description              = each.value.description
  region                   = each.value.region
  interconnect             = each.value.type == "DEDICATED" ? each.value.interconnect : null           # If type is "DEDICATED", assign the provided interconnect value. If type is "PARTNER", automatically set interconnect to null.  
  edge_availability_domain = each.value.type == "PARTNER" ? each.value.edge_availability_domain : null # Only available for type PARTNER, at creation time
  type                     = each.value.type
  encryption               = each.value.encryption
  ipsec_internal_addresses = each.value.encryption == "IPSEC" ? [
    for ip in each.value.ip_configs :
    google_compute_address.ip["${each.key}-${ip.name}"].self_link
  ] : null
  router = each.value.router_name
  mtu    = each.value.mtu

  depends_on = [
    google_compute_address.ip
  ]
}
