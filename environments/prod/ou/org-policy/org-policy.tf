###################
#  Org Policies   #
###################
module "org-polcy" {
  source       = "../../../../modules/ou/org-policy"
  org_policies = var.org_policies
}