#######################
#  Service Account    #
#######################
module "service_account" {
  source           = "../../../../../modules/iam/service-account"
  service_accounts = var.service_accounts
}

##############################
#  Project-Level IAM Roles   #
##############################
module "member_roles" {
  for_each       = { for idx, sa in var.service_accounts : idx => sa if sa.project_roles != null }
  source         = "../../../../../modules/iam/iam-member"
  member_address = "${each.value.account_id}@${each.value.project_id}.iam.gserviceaccount.com"
  role_bindings = [for pr in each.value.project_roles : {
    project = pr.project
    roles   = pr.roles
  }]
  depends_on = [module.service_account]
}

#############################
#  Folder-Level IAM Roles   #
#############################
module "folder_roles" {
  for_each       = { for idx, sa in var.service_accounts : idx => sa if sa.folder_roles != null }
  source         = "../../../../../modules/iam/folder-iam-member"
  member_address = "${each.value.account_id}@${each.value.project_id}.iam.gserviceaccount.com"
  role_bindings = [for pr in each.value.folder_roles : {
    folder = pr.folder
    roles  = pr.roles
  }]
  depends_on = [module.service_account]
}

##########################
#  Org-Level IAM Roles   #
##########################
module "org_roles" {
  for_each       = { for idx, sa in var.service_accounts : idx => sa if sa.org_roles != null }
  source         = "../../../../../modules/iam/org-iam-member"
  member_address = "${each.value.account_id}@${each.value.project_id}.iam.gserviceaccount.com"
  role_bindings = [for pr in each.value.org_roles : {
    org_id = pr.org_id
    roles  = pr.roles
  }]
  depends_on = [module.service_account]
}

#########################
#  SA-Level IAM Roles   #
#########################
# Grants service account-level IAM roles to external members (e.g., WIF) for impersonation for respective service account
module "service_account_member" {
  source   = "../../../../../modules/iam/service-account-iam-member"
  for_each = { for idx, sa in var.service_accounts : idx => sa if sa.service_account_members != null }

  service_account_members = [for sm in each.value.service_account_members : {
    service_account_email = "projects/${each.value.project_id}/serviceAccounts/${each.value.account_id}@${each.value.project_id}.iam.gserviceaccount.com"
    role                  = sm.role
    member                = sm.member
  }]
  depends_on = [module.service_account]
}
