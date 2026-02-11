#########################
#  SA-Level IAM Roles   #
#########################
# Grants service account-level IAM roles to external members (e.g., WIF) for impersonation for respective service account
variable "service_account_members" {
  description = "A list of objects defining IAM bindings for service accounts."
  type = list(object({
    service_account_email = string # (Required) The email address of the service account to which the member will be granted role on.
    role                  = string # (Required) The IAM role to assign to the member (e.g., roles/viewer, roles/editor).
    member                = string # (Required) The member to bind to the role (e.g., user:john@example.com, serviceAccount:xyz@project.iam.gserviceaccount.com).
  }))
}