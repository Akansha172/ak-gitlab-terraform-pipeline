################
#  Project ID  #
################
variable "project_id" {
  description = "The ID of the project"
  type        = string
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
