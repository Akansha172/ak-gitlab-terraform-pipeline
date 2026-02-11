################
#  Project ID  #
################
variable "project_id" {
  description = "Project id of the project that holds the network."
  type        = string
}

#################
#  VPC Network  #
#################
variable "network_name" {
  description = "Name of the network list of firewalls rules applies to."
  type        = string
}

####################
#  Firewall Rules  #
####################
variable "rules" {
  description = "List of firewall rules"
  type = list(object({
    name                    = string                       # (Required) Name of the firewall rule. Must be 1-63 characters, matching RFC1035 ([a-z]([-a-z0-9]*[a-z0-9])?).
    description             = optional(string, null)       # (Optional) Description of the firewall rule.
    direction               = optional(string, "INGRESS")  # (Optional) Direction of traffic. Valid values: "INGRESS", "EGRESS". Default: "INGRESS".
    disabled                = optional(bool, false)        # (Optional) If true, the firewall rule is disabled. Default: false.
    priority                = optional(number, 1000)       # (Optional) Priority between 0–65535. Lower number = higher priority. Default: 1000.
    ranges                  = optional(list(string), [])   # (Optional) IPv4 or IPv6 CIDR ranges this rule applies to (for INGRESS: required if no tags or service accounts specified).
    source_tags             = optional(list(string), null) # (Optional) List of source instance tags, required for INGRESS.
    source_service_accounts = optional(list(string), null) # (Optional) Source service accounts (mutually exclusive with source_tags and target_tags), required for INGRESS..
    target_tags             = optional(list(string), null) # (Optional) Target instance tags.
    target_service_accounts = optional(list(string), null) # (Optional) Target service accounts (mutually exclusive with target_tags or source_tags).

    # ALLOW rules
    allow = optional(list(object({
      protocol = string                 # (Required) Protocol to allow. Valid: "tcp", "udp", "icmp", "esp", "ah", "sctp", "ipip", "all".
      ports    = optional(list(string)) # (Optional) List of ports (e.g. ["22"], ["80", "443"], ["1234-1239"]).
    })), [])                            # (Optional) List of ALLOW rules. Empty list by default.

    # DENY rules
    deny = optional(list(object({
      protocol = string                 # (Required) Protocol to deny. Valid: "tcp", "udp", "icmp", "esp", "ah", "sctp", "ipip", "all".
      ports    = optional(list(string)) # (Optional) List of ports to deny.
    })), [])                            # (Optional) List of DENY rules. Empty list by default.

    # Logging configuration
    log_config = optional(object({
      metadata = string # (Required) Metadata logging option. Valid: "INCLUDE_ALL_METADATA", "EXCLUDE_ALL_METADATA".
    }))
  }))
}