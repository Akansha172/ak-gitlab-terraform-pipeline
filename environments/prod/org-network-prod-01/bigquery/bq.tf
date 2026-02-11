###############
#  Big Query  #
###############
module "bq_module" {
  source     = "../../../../modules/bigquery"
  id_map     = var.id_map
  project_id = var.project_id
  location   = var.location
}