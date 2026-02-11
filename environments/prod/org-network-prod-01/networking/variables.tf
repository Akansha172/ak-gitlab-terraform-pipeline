################
#  Project ID  #
################
variable "project_id" {
  description = "The ID of the project where this VPC will be created"
  type        = string
}

#########
#  VPC  #
#########
variable "vpc" {
  description = "The list of VPC being created"
  type = map(object({
    routing_mode                    = string
    auto_create_subnetworks         = bool
    delete_default_routes_on_create = bool
  }))
  default = {}
}

############
#  Subnet  #
############
variable "subnets" {
  description = "The list of subnets being created"
  type = map(object({
    network_name          = string
    subnet_ip             = string
    subnet_region         = string
    subnet_private_access = bool
  }))
  default = {}
}

#############################
#  PRIVATE SERVICE ACCESS  #
#############################
variable "global_address" {
  description = "The list of subnets being created"
  type = map(object({
    vpc_name      = string
    ipv4_address  = string
    address_type  = string
    purpose       = string
    prefix_length = string
    service       = string
  }))
  default = {}
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

###############
#  Cloud NAT  # 
###############
variable "cloud_nat" {
  description = "The list of subnets being created"
  type = map(object({
    router_name                        = string
    region                             = string
    nat_ip_allocate_option             = string
    source_subnetwork_ip_ranges_to_nat = string
  }))
  default = {}
}
