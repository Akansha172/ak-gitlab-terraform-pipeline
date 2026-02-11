###################
#  GCP Projects   #
###################
variable "projects" {
  type = list(object({
    name                = string                    # (Required) Display name of the GCP project.
    project_id          = string                    # (Required) Unique ID for the project (used in APIs, must be globally unique).
    billing_account     = optional(string, null)    # (Optional) Billing account ID to link with the project (e.g., "01A1B2-C3D4E5-6F7G8H").
    org_id              = optional(string, null)    # (Optional) Organization ID under which the project will be created.
    auto_create_network = optional(bool, false)     # (Optional) Whether to create the default VPC network. Defaults to false.
    folder_id           = optional(string, null)    # (Optional) Folder ID to nest the project under a specific folder.
    tags                = optional(map(string), {}) # (Optional) Key-value labels to assign to the project for organization, billing, or filtering.
  }))
}
