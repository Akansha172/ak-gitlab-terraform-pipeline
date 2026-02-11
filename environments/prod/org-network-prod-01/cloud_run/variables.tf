################
#  Project ID  #
################
variable "project_id" {
  type        = string
  description = "ID of project" # (Required) The ID of the GCP project.
}

##############
#  Location  #
##############
variable "location" {
  type        = string
  description = "location of the service" # (Required) The region where the Cloud Run service will be deployed (e.g., "us-central1").
}

########################
#  Cloud Run Services  #
########################
variable "cloud_run_svc" {
  type        = list(string)
  description = "map of cloud run services" # (Required) List of Cloud Run service names to be deployed or managed.
  default = []
}

variable "percent" {
  type        = number
  description = "Traffic percentage to latest revision" # (Required) Percentage of traffic to route to the latest revision (e.g., 100 for full traffic).
  default = null
}

variable "image" {
  type        = string
  description = "Image for the containers" # (Required) The container image to deploy (e.g., "gcr.io/project-id/service-image:tag").
  default = ""
}

variable "latest_revision" {
  type        = bool
  description = "Whether to send traffic to latest revision"
  default     = true # (Optional) If true, traffic will be directed to the latest revision of the service. Default is true.
}

