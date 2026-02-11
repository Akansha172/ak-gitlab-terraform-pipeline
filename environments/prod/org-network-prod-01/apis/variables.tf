################
#  Project ID  #
################
variable "project_id" {
  description = "The ID of the GCP project where APIs will be enabled"
  type        = string # (Required) GCP Project ID where the APIs will be enabled.
}

#########################
#  APIs List to enable  #
#########################
variable "api_list" {
  description = "A list of APIs to enable"
  type        = list(string) # (Required) List of API names (e.g., 'compute.googleapis.com') to be enabled in the specified GCP project.
}

######################
#  Disable Criteria  #
######################
variable "disable_on_destroy" {
  description = "Whether to disable the API when the resource is destroyed"
  type        = bool
  default     = false # (Optional) If true, disables the API when the Terraform resource is destroyed. Default is false.
}

variable "disable_dependent_services" {
  description = "Whether to disable dependent services when the resource is destroyed"
  type        = bool
  default     = false # (Optional) If true, disables any services that depend on the API being disabled. Default is false.
}
