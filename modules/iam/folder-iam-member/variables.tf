#####################
#  Member details   #
#####################
variable "member_address" {
  description = "Email address of member"
  type        = string # (Required) The email address of the member (e.g., user@example.com, group@example.com, service-account@example.iam.gserviceaccount.com).
}

variable "prefix" {
  description = "Prefix member or group or serviceaccount"
  type        = string           # (Optional) The IAM member type prefix: 'user', 'group', or 'serviceAccount'.
  default     = "serviceAccount" # Default is 'serviceAccount'.
}

#############################
#  Folder-Level IAM Roles   #
#############################
variable "role_bindings" {
  type = list(object({
    folder = string       # (Required) Folder ID where the roles will be applied.
    roles  = list(string) # (Required) List of IAM roles to assign (e.g., roles/editor, roles/viewer).
  }))
}
