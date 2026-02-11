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