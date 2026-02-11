################
#  Project ID  #
################
variable "project_id" {
  description = "The ID of the project where subnets will be created"
  type        = string
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

variable "secondary_ranges" {
  description = "Secondary ranges that will be used in some of the subnets"
  type = map(list(object({
    range_name    = string
    ip_cidr_range = string
  })))
  default = {}
}