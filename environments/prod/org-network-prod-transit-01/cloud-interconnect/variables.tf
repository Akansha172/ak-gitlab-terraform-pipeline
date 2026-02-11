################
#  Project ID  #
################
variable "project_id" {
  description = "The ID of the project"
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


####################################
#  Interconnect Attachment (VLAN)  #
####################################
variable "interconnect_attachments" {
  description = "Map of interconnect attachments along with router and IP configuration details"
  type = map(object({
    description              = optional(string, "")                        # Optional,  An optional description
    region                   = optional(string, "")                        # Optional,  Region of attachment
    interconnect             = optional(string, "")                        # Optional, URL of the underlying Interconnect object that this attachment's traffic will traverse through. Required if type is DEDICATED, must not be set if type is PARTNER.
    edge_availability_domain = optional(string, "AVAILABILITY_DOMAIN_ANY") # Optional, Availability domain for the attachment. Only available for type PARTNER, at creation time
    type                     = optional(string, "")                        # Optional, Type of attachment. Possible values: PARTNER, DEDICATED(default)
    mtu                      = optional(number)                            # Optional, Maximum Transmission Unit (MTU) size
    encryption               = optional(string, "NONE")                    # Optional, Encryption options for attachment, default is NONE
    ipsec_internal_addresses = optional(list(string), [])                  # Optional, URL of addresses, Used only for interconnect attachment that has the encryption option as IPSEC.
    router_name              = string                                      # (Required) Name of the associated router

    ip_configs = optional(list(object({
      name          = string                                 # (Required) Name of the IP address resource (must follow RFC1035)
      address       = optional(string)                       # Optional, Static IP address (if not set, Google will assign)
      address_type  = optional(string, "INTERNAL")           # Optional, Type of address: INTERNAL or EXTERNAL (default is INTERNAL)
      purpose       = optional(string, "IPSEC_INTERCONNECT") # Optional, Purpose of the IP (default: IPSEC_INTERCONNECT)
      description   = optional(string)                       # Optional, Description for the IP
      network       = optional(string)                       # Optional, Network URL (required for INTERNAL with specific purposes)
      subnetwork    = optional(string)                       # Optional, Subnetwork URL (for INTERNAL with GCE_ENDPOINT/DNS_RESOLVER)
      network_tier  = optional(string)                       # Optional, Network tier (PREMIUM or STANDARD, EXTERNAL only)
      labels        = optional(map(string), {})              # Optional, Key-value labels for the IP
      prefix_length = optional(number)                       # Optional, Prefix length if reserving a range
      ip_version    = optional(string, "IPV4")               # Optional, IP version (IPV4 or IPV6)
      project       = optional(string)                       # Optional, Project ID for the IP (defaults to provider project)
    })), [])
  }))
  default = {}
}

#######################
#  Router Interfaces  #
#######################
variable "router_interfaces" {
  description = "Map of Cloud Router Interfaces"
  type = map(object({
    router                  = string                   # (Required) Attached Router name
    ip_range                = optional(string)         # Optional: IP range (RFC3927 link-local)
    ip_version              = optional(string, "IPV4") # Optional: IPV4 or IPV6
    vpn_tunnel              = optional(string)         # Optional: Link to VPN tunnel
    interconnect_attachment = optional(string)         # Optional: VLAN interconnect link
    subnetwork              = optional(string)         # Optional: Subnetwork URI
    redundant_interface     = optional(string)         # Optional: Redundant interface name
    private_ip_address      = optional(string)         # Optional: Private IP for BGP to third-party router
    project                 = optional(string)         # Optional: GCP project ID
    region                  = optional(string)         # Optional: Region where router resides
  }))
  default = {}
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



#####################
#  HA VPN Gateways  #
#####################
variable "ha_vpn_gateways" {
  description = "Map of HA VPN gateways and their configurations"
  type = map(object({
    network            = string                        # (Required) Network this gateway is attached to
    description        = optional(string, "")          # Optional, Description of the gateway
    region             = optional(string)              # Optional, Region in which this gateway should reside
    project            = optional(string)              # Optional, Project ID, fallback to provider project
    stack_type         = optional(string, "IPV4_ONLY") # Optional, Stack type for VPN protocol
    gateway_ip_version = optional(string, "IPV4")      # Optional, IP family of the gateway IPs
    labels             = optional(map(string), {})     # Optional, Labels for the VPN gateway
    vpn_interfaces = optional(list(object({
      id                      = optional(number) # Optional, Numeric ID of the interface
      interconnect_attachment = optional(string) # Optional, URL of the interconnect attachment
    })), [])                                     # Optional, List of interfaces
  }))
  default = {}
}


###########################
#  External VPN Gateways  #
###########################
variable "external_vpn_gateways" {
  description = "Map of external VPN gateways keyed by name"
  type = map(object({
    description     = optional(string, "")                    # (Optional) Description of the VPN gateway
    labels          = optional(map(string), {})               # (Optional) Labels for the gateway
    redundancy_type = optional(string, "FOUR_IPS_REDUNDANCY") # (Optional) Redundancy type. Default is FOUR_IPS_REDUNDANCY, Possible values are: FOUR_IPS_REDUNDANCY, SINGLE_IP_INTERNALLY_REDUNDANT, TWO_IPS_REDUNDANCY.
    project         = optional(string, null)                  # (Optional) Project ID. Uses provider project if not set.

    interfaces = optional(list(object({ # (Optional) List of interfaces
      id           = optional(number)   # (Optional) ID: depends on redundancy_type
      ip_address   = optional(string)   # (Optional) IPv4 address
      ipv6_address = optional(string)   # (Optional) IPv6 address
    })), [])
  }))
  default = {}
}

#################
#  VPN Tunnels  #
#################
variable "vpn_tunnels" {
  description = "Map of VPN tunnel configurations keyed by tunnel name"
  type = map(object({
    name          = string                 # (Required) Name of the VPN tunnel
    shared_secret = string                 # (Required) Shared secret used for the secure session
    description   = optional(string, null) # (Optional) Description of the VPN tunnel

    target_vpn_gateway    = optional(string, null) # (Optional) URL of target VPN gateway (classic)
    vpn_gateway           = optional(string, null) # (Optional) URL of HA VPN gateway
    vpn_gateway_interface = optional(number, null) # (Optional) Interface ID of the HA VPN gateway

    peer_external_gateway           = optional(string, null) # (Optional) URL of the external VPN gateway
    peer_external_gateway_interface = optional(number, null) # (Optional) Interface ID of the external gateway
    peer_gcp_gateway                = optional(string, null) # (Optional) URL of peer side HA GCP VPN gateway

    router = optional(string, null) # (Optional) Router used for dynamic routing
    region = optional(string, null) # (Optional) Region of the VPN tunnel

    peer_ip     = optional(string, null) # (Optional) Peer VPN gateway IP (IPv4 only)
    ike_version = optional(number, 2)    # (Optional) IKE version (1 or 2). Default: 2

    local_traffic_selector  = optional(list(string), []) # (Optional) Local CIDR selectors
    remote_traffic_selector = optional(list(string), []) # (Optional) Remote CIDR selectors

    labels  = optional(map(string), {}) # (Optional) Key-value labels
    project = optional(string, null)    # (Optional) Project ID
  }))
}
