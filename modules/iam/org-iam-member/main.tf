##########################
#  Org-Level IAM Roles   #
##########################
resource "google_organization_iam_member" "organization_iam_member" {
  for_each = { for rb in flatten([for binding in var.role_bindings : [
    for role in binding.roles : {
      org_id = binding.org_id
      role   = role
    }
  ]]) : "${rb.org_id}-${rb.role}" => rb }

  org_id = each.value.org_id
  role   = each.value.role
  member = "${coalesce(var.prefix, "serviceAccount")}:${var.member_address}"
}
