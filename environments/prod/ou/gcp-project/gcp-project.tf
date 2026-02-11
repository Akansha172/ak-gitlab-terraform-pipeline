###################
#  GCP Projects   #
###################
module "projects" {
  source   = "../../../../modules/ou/gcp-project"
  projects = var.projects
}
