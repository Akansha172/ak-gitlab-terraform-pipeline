#########################
#  SA-Level IAM Roles   #
#########################
# Grants service account-level IAM roles to external members (e.g., WIF) for impersonation for respective service account
resource "google_service_account_iam_member" "service_account_member" {
  for_each = { for idx, sa in var.service_account_members : idx => sa }

  service_account_id = each.value.service_account_email
  role               = each.value.role
  member             = each.value.member
}