##########
#  APIs  #
##########
module "apis" {
  source     = "../../../../modules/apis"
  project_id = var.project_id
  api_list   = var.api_list
}