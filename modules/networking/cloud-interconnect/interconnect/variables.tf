###########################
#  Interconnect Physical  #
###########################
/*This resource is only needed while setting up DEDICATED interconnect*/
variable "interconnects" {
  description = "Map of interconnect configurations"
  type = map(object({
    name                 = string               # (Required) Name of the interconnect. Must be 1-63 characters long and match RFC1035.
    interconnect_type    = string               # (Required) Type of interconnect. Possible values: DEDICATED, PARTNER
    link_type            = string               # (Required) Type of link requested. Possible values: LINK_TYPE_ETHERNET_10G_LR, LINK_TYPE_ETHERNET_100G_LR, LINK_TYPE_ETHERNET_400G_LR4
    requested_link_count = number               # (Required) Number of physical links requested
    location             = optional(string, "") # (Optional) URL of the InterconnectLocation object that represents where this connection is to be provisioned
    description          = optional(string, "") # (Optional) Description
    customer_name        = optional(string, "") # (Optional) Required for Dedicated and Partner, Customer name, to put in the Letter of Authorization as the party authorized to request a crossconnect
    noc_contact_email    = optional(string, "") # (Optional) Email address to contact the customer NOC for operations and maintenance notifications regarding this Interconnect. If specified, this will be used for notifications in addition to all other forms described, such as Cloud Monitoring logs alerting and Cloud Notifications.
  }))
  default = {}
}
