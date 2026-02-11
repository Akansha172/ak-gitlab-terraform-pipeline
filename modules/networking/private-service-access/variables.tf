################
#  Project ID  #
################
variable "project_id" {
  description = "The ID of the project."
  type        = string
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