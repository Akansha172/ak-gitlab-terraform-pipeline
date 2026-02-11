########################
#  Cloud Run Services  #
########################
module "cloud_run_services" {
  source          = "../../../../modules/cloud_run"
  project_id      = var.project_id
  cloud_run_svc   = var.cloud_run_svc
  location        = var.location
  image           = var.image
  percent         = var.percent
  latest_revision = var.latest_revision
}
