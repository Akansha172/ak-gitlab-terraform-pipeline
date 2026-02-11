################
#  Project ID  #
################
variable "project_id" {
  description = "The ID of the project"
  type        = string
}


################
# Router Peers #
################
variable "router_peers" {
  description = "Map of router peer configurations keyed by peer name"
  type = map(object({
    interface                 = string                       # (Required) Name of the interface the peer is associated with
    peer_asn                  = number                       # (Required) Peer ASN
    router                    = string                       # (Required) Name of the Cloud Router
    region                    = optional(string, null)       # (Optional) Region of the router and peer
    project                   = optional(string, null)       # (Optional) Project ID
    ip_address                = optional(string, null)       # (Optional) IP address of the Cloud Router interface
    peer_ip_address           = optional(string, null)       # (Optional) IP address of the BGP peer
    advertised_route_priority = optional(number, 100)        # (Optional) Priority of advertised routes. Default is 100.
    advertise_mode            = optional(string, "DEFAULT")  # (Optional) Advertise mode: DEFAULT or CUSTOM
    advertised_groups         = optional(list(string), null) # (Optional) Prefix groups to advertise in CUSTOM mode

    advertised_ip_ranges = optional(list(object({ # (Optional) List of advertised IP ranges
      range       = string                        # (Required) CIDR-formatted IP range to advertise
      description = optional(string, null)        # (Optional) Description of the advertised range
    })), [])                                      # (Optional) List of advertised IP ranges

    custom_learned_ip_ranges = optional(list(object({
      range = string # (Required) Custom learned IP range (CIDR)
    })), [])         # (Optional) IP ranges to learn from the peer

    custom_learned_route_priority      = optional(number, null) # (Optional) Priority for custom learned routes
    zero_custom_learned_route_priority = optional(bool, null)   # (Optional) Force priority to 0

    bfd = optional(object({                                # (Optional) BFD configuration
      session_initialization_mode = string                 # (Required) BFD mode
      min_transmit_interval       = optional(number, null) # (Optional) Min transmit interval (ms)
      min_receive_interval        = optional(number, null) # (Optional) Min receive interval (ms)
      multiplier                  = optional(number, null) # (Optional) Missed packets before peer is declared unavailable
    }), null)

    md5_authentication_key = optional(object({ # (Optional) MD5 authentication key config
      name = string                            # (Required) Unique key name
      key  = string                            # (Required) MD5 key
    }), null)

    enable                    = optional(bool, true)       # (Optional) Whether BGP peer is enabled
    enable_ipv6               = optional(bool, false)      # (Optional) Enable IPv6 traffic over BGP peer
    enable_ipv4               = optional(bool, true)       # (Optional) Enable IPv4 traffic over BGP peer
    ipv6_nexthop_address      = optional(string, null)     # (Optional) IPv6 address inside GCP (router side)
    ipv4_nexthop_address      = optional(string, null)     # (Optional) IPv4 address inside GCP (router side)
    peer_ipv6_nexthop_address = optional(string, null)     # (Optional) IPv6 address of peer side
    peer_ipv4_nexthop_address = optional(string, null)     # (Optional) IPv4 address of peer side
    router_appliance_instance = optional(string, null)     # (Optional) URI of VM used as router appliance
    import_policies           = optional(list(string), []) # (Optional) List of import route policy names
    export_policies           = optional(list(string), []) # (Optional) List of export route policy names
  }))
}
