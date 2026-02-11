################
#  Project ID  #
################
project_id = "org-shared-services-01"

##############################
#  Workload Identity Pools   #
##############################
pools = [
  "org-wif-pool-prod-gitlab"
]

##################################
#  Workload Identity Providers   #
##################################
identity_providers = {
  "org-wif-provider-prod-gitlab" = {
    pool_name           = "org-wif-pool-prod-gitlab"
    attribute_condition = "assertion.project_path == 'myteam/myorg-tf-new'"
    url                 = "https://gitlab.com"
    attribute_mapping = {
      "google.subject"           = "assertion.sub",
      "attribute.aud"            = "assertion.aud",
      "attribute.project_path"   = "assertion.project_path",
      "attribute.project_id"     = "assertion.project_id",
      "attribute.namespace_id"   = "assertion.namespace_id",
      "attribute.namespace_path" = "assertion.namespace_path",
      "attribute.user_email"     = "assertion.user_email",
      "attribute.ref"            = "assertion.ref",
      "attribute.ref_type"       = "assertion.ref_type",
    }
  }
}
