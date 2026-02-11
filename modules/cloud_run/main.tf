########################
#  Cloud Run Services  #
########################
resource "google_cloud_run_service" "cloud_run" {
  for_each = toset(var.cloud_run_svc)
  name     = each.value
  location = var.location

  template {
    spec {
      containers {
        image = var.image
      }
    }
  }

  traffic {
    percent         = var.percent
    latest_revision = var.latest_revision
  }
}