################
#  Project ID  #
################
variable "project_id" {
  description = "Name of the project"
  type        = string
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