##############################
#  Workload Identity Pools   #
##############################
resource "google_iam_workload_identity_pool" "wif_pools" {
  for_each                  = toset(var.pools)
  workload_identity_pool_id = each.key
  project                   = var.project_id
}
