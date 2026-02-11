#######################
#  Service Account    #
#######################
resource "google_service_account" "service_account" {
  for_each = { for idx, sa in var.service_accounts : idx => sa }

  account_id                   = each.value.account_id
  display_name                 = each.value.display_name
  description                  = each.value.description
  project                      = each.value.project_id
  disabled                     = each.value.disabled
  create_ignore_already_exists = each.value.create_ignore_already_exists
}
