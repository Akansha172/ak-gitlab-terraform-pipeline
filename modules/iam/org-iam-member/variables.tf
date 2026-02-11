#####################
#  Member details   #
#####################
variable "member_address" {
  description = "Email address of member"
  type        = string # (Required) The email address of the member (e.g., user@example.com, group@example.com).
}

variable "prefix" {
  description = "Prefix member or group or serviceaccount"
  type        = string           # (Optional) Prefix to prepend before member address. Typically 'user', 'group', or 'serviceAccount'.
  default     = "serviceAccount" # Default is 'serviceAccount'.
}

##########################
#  Org-Level IAM Roles   #
##########################
variable "role_bindings" {
  type = list(object({
    org_id = string       # (Required) Organization ID where the roles will be applied.
    roles  = list(string) # (Required) List of IAM roles to bind to the member (e.g., roles/resourcemanager.projectViewer).
  }))
}