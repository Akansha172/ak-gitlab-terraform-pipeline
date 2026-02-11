################
#  Project ID  #
################
variable "project_id" {
  description = "The ID of the project where this VPC will be created"
  type        = string
}

#####################
#  Host Project ID  #
#####################
variable "host_project_id" {
  description = "The ID of the host project from where VPCs to other projects will be shared"
  type        = string
  default = null
}

######################
#  Service Projects  #
######################
variable "service_projects" {
  description = "A list of service project IDs"
  type        = list(string)
  default = []
}