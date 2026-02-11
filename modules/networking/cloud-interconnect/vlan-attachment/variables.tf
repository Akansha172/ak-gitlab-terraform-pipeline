################
#  Project ID  #
################
variable "project_id" {
  description = "Project id of the project."
  type        = string
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
