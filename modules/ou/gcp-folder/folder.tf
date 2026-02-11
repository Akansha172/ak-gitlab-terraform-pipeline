##################
#  GCP Folders   #
##################
resource "google_folder" "folders" {
  for_each     = { for item in var.folders : "${item.parent}-${item.name}" => item }
  display_name = each.value.name
  parent       = each.value.parent
  tags         = each.value.tags
}
