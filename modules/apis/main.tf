##########
#  APIs  #
##########
resource "google_project_service" "apis" {
  for_each = toset(var.api_list)

  project = var.project_id
  service = each.value

  disable_on_destroy         = var.disable_on_destroy
  disable_dependent_services = var.disable_dependent_services
}