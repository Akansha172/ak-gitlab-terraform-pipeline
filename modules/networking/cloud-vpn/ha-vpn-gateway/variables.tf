################
#  Project ID  #
################
variable "project_id" {
  description = "Project id of the project that holds the network."
  type        = string
}

####################
#  HA VPN Gateway  #
####################
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

