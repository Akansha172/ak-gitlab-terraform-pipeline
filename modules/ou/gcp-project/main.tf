###################
#  GCP Projects   #
###################
resource "google_project" "projects" {
  for_each            = { for item in var.projects : item.name => item }
  name                = each.value.name
  project_id          = each.value.project_id
  billing_account     = each.value.billing_account
  org_id              = each.value.org_id
  auto_create_network = each.value.auto_create_network
  folder_id           = each.value.folder_id
  tags                = each.value.tags
}

