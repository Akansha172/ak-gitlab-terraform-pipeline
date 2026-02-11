##############################
#  Project-Level IAM Roles   #
##############################
resource "google_project_iam_member" "project_iam_member" {
  for_each = { for rb in flatten([for binding in var.role_bindings : [
    for role in binding.roles : {
      project = binding.project
      role    = role
    }
  ]]) : "${rb.project}-${rb.role}" => rb }

  project = each.value.project
  role    = each.value.role
  member  = "${coalesce(var.prefix, "serviceAccount")}:${var.member_address}"
}
