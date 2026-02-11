################
#  Project ID  #
################
variable "project_id" {
  description = "The default project ID where routers will be created (can be overridden per router)"
  type        = string
}

###################
#  Cloud Routers  #
###################
variable "routers" {
  description = "Map of router names to their configuration objects"
  type = map(object({
    region                        = string                 # (Required) Region of the router
    network                       = string                 # (Required) Network to which the router is attached
    description                   = optional(string, null) # (Optional) Description of the router
    encrypted_interconnect_router = optional(bool, null)   # (Optional) If true, router is for encrypted VLAN attachments

    md5_authentication_keys = optional(list(object({ # (Optional) MD5 authentication keys for BGP
      name = string                                  # (Required) Unique name for the key (RFC1035 compliant)
      key  = string                                  # (Required) Value of the key
    })), [])

    bgp = optional(object({                             # (Optional) BGP configuration block
      asn                = number                       # (Required) ASN for BGP sessions if bgp is defined
      keepalive_interval = optional(number, null)       # (Optional) Keepalive interval (20–60)
      advertise_mode     = optional(string, null)       # (Optional) Advertise mode: DEFAULT or CUSTOM
      advertised_groups  = optional(list(string), null) # (Optional) Prefix groups to advertise (e.g., ["ALL_SUBNETS"])
      advertised_ip_ranges = optional(list(object({     # (Optional) IP ranges to advertise
        range       = string                            # (Required) CIDR range to advertise
        description = optional(string, null)            # (Optional) Description for the IP range
      })), [])
    }), null)
  }))
  default = {}
}
