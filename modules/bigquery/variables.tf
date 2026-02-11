################
#  Project ID  #
################
variable "project_id" {
  type        = string
  description = "ID of project" # (Required) The ID of the GCP project where the BigQuery dataset(s) will be created.
}

##############
#  Location  #
##############
variable "location" {
  type        = string
  description = "location of the dataset" # (Required) The geographic location where the BigQuery dataset(s) will be stored (e.g., "US", "EU").
}

######################
#  Big Query Tables  #
######################
variable "id_map" {
  type        = map(string)
  description = "Map of dataset IDs" # (Required) A map of dataset identifiers. Useful for creating multiple datasets with specific IDs, # Example: { "analytics" = "analytics_dataset", "logs" = "logs_dataset" }
}

variable "deletion_protection" {
  type        = bool
  description = "true to enable deletion protection(in production)"
  default     = true
}

