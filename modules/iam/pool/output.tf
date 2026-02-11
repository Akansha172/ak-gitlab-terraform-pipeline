output "workload_identity_pools" {
  value = { for k, v in google_iam_workload_identity_pool.wif_pools : k => v.workload_identity_pool_id }
}
