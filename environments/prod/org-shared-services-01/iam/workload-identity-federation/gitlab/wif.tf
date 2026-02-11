##############################
#  Workload Identity Pools   #
##############################
module "pool" {
  source     = "../../../../../../modules/iam/pool"
  project_id = var.project_id
  pools      = var.pools
}

##################################
#  Workload Identity Providers   #
##################################
module "provider" {
  source             = "../../../../../../modules/iam/provider"
  project_id         = var.project_id
  identity_providers = var.identity_providers
  depends_on         = [module.pool]
}
