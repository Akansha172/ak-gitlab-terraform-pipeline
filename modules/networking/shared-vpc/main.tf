################
#  Shared VPC  #
################
resource "google_compute_shared_vpc_host_project" "host" {
  count   = var.host_project_id != null ? 1 : 0
  project = var.host_project_id
}

resource "google_compute_shared_vpc_service_project" "service" {
  for_each = var.host_project_id != null ? toset(var.service_projects) : toset([])

  host_project    = google_compute_shared_vpc_host_project.host[0].project
  service_project = each.value
}
