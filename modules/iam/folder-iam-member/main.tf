#############################
#  Folder-Level IAM Roles   #
#############################
resource "google_folder_iam_member" "folder_iam_member" {
  for_each = { for rb in flatten([for binding in var.role_bindings : [
    for role in binding.roles : {
      folder = binding.folder
      role   = role
    }
  ]]) : "${rb.folder}-${rb.role}" => rb }

  folder = each.value.folder
  role   = each.value.role
  member = "${coalesce(var.prefix, "serviceAccount")}:${var.member_address}"
}
