################
#  Project ID  #
################
variable "project_id" {
  description = "The ID of the project"
  type        = string
}

###########################
#  External VPN Gateways  #
###########################
variable "external_vpn_gateways" {
  description = "Map of external VPN gateways keyed by name"
  type = map(object({
    description     = optional(string, "")                    # (Optional) Description of the VPN gateway
    labels          = optional(map(string), {})               # (Optional) Labels for the gateway
    redundancy_type = optional(string, "FOUR_IPS_REDUNDANCY") # (Optional) Redundancy type. Default is FOUR_IPS_REDUNDANCY
    project         = optional(string, null)                  # (Optional) Project ID. Uses provider project if not set.

    interfaces = optional(list(object({ # (Optional) List of interfaces
      id           = optional(number)   # (Optional) ID: depends on redundancy_type
      ip_address   = optional(string)   # (Optional) IPv4 address
      ipv6_address = optional(string)   # (Optional) IPv6 address
    })), [])
  }))
  default = {}
}
