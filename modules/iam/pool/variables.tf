################
#  Project ID  #
################
variable "project_id" {
  description = "GCP Project ID"
  type        = string # (Required) The ID of the GCP project where the Workload Identity Pools and Providers will be created.
}

##############################
#  Workload Identity Pools   #
##############################
variable "pools" {
  description = "List of Workload Identity Pools"
  type        = list(string) # (Required) A list of Workload Identity Pool names to be created in the project.
}
