##################################
#  Workload Identity Providers   #
##################################
resource "google_iam_workload_identity_pool_provider" "wif_providers" {
  for_each                           = var.identity_providers
  workload_identity_pool_id          = each.value.pool_name
  workload_identity_pool_provider_id = each.key
  project                            = var.project_id
  attribute_condition                = each.value.attribute_condition

  attribute_mapping = each.value.attribute_mapping

  oidc {
    issuer_uri        = each.value.url
    allowed_audiences = each.value.allowed_audiences
  }
}
