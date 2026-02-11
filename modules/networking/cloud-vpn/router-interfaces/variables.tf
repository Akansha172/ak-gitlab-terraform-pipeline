################
#  Project ID  #
################
variable "project_id" {
  description = "The ID of the project"
  type        = string
}

#######################
#  Router Interfaces  #
#######################
variable "router_interfaces" {
  description = "Map of Cloud Router Interfaces"
  type = map(object({
    router                  = string                   # (Required) Attached Router name
    ip_range                = optional(string, null)   # Optional: IP range (RFC3927 link-local)
    ip_version              = optional(string, "IPV4") # Optional: IPV4 or IPV6
    vpn_tunnel              = optional(string, null)   # Optional: Link to VPN tunnel
    interconnect_attachment = optional(string, null)   # Optional: VLAN interconnect link
    subnetwork              = optional(string, null)   # Optional: Subnetwork URI
    redundant_interface     = optional(string, null)   # Optional: Redundant interface name
    private_ip_address      = optional(string, null)   # Optional: Private IP for BGP to third-party router
    project                 = optional(string, null)   # Optional: GCP project ID
    region                  = optional(string, null)   # Optional: Region where router resides
  }))
  default = {}
}
