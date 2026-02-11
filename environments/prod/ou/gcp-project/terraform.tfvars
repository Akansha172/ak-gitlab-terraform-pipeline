###################
#  GCP Projects   #
###################
projects = [
  {
    name                = "org-shared-services-01"
    project_id          = "org-shared-services-01"
    folder_id           = "<folder-id-8>" # shared services id
    auto_create_network = true
    billing_account     = "0165D9-2DF980-F799D0"
  },
  {
    name                = "org-network-dev-01"
    project_id          = "org-network-dev-01"
    folder_id           = "<folder-id-9>" # network -> dev id
    auto_create_network = true
    billing_account     = "0165D9-2DF980-F799D0"
  },
  {
    name                = "org-network-prod-01"
    project_id          = "org-network-prod-01"
    folder_id           = "<folder-id-10>" # network -> prod id
    auto_create_network = true
    billing_account     = "0165D9-2DF980-F799D0"
  },
  {
    name                = "org-network-prod-transit-01"
    project_id          = "org-network-prod-transit-01"
    folder_id           = "<folder-id-10>" # network -> prod id
    auto_create_network = true
    billing_account     = "0165D9-2DF980-F799D0"
  },
  {
    name                = "org-security-dev-logging-01"
    project_id          = "org-security-dev-logging-01"
    folder_id           = "<folder-id-11>" # security -> dev id
    auto_create_network = true
    billing_account     = "0165D9-2DF980-F799D0"
  },
  {
    name                = "org-security-dev-compliance-01"
    project_id          = "org-security-dev-compliance-01"
    folder_id           = "<folder-id-11>" # security -> dev id
    auto_create_network = true
    billing_account     = "0165D9-2DF980-F799D0"
  },
  {
    name                = "org-security-prod-logging-01"
    project_id          = "org-security-prod-logging-01"
    folder_id           = "<folder-id-12>" # security -> prod id
    auto_create_network = true
    billing_account     = "0165D9-2DF980-F799D0"
  },
  {
    name                = "org-security-prod-compliance-01"
    project_id          = "org-security-prod-compliance-01"
    folder_id           = "<folder-id-12>" # security -> prod id
    auto_create_network = true
    billing_account     = "0165D9-2DF980-F799D0"
  },
  {
    name                = "org-bc-dev-data-01"
    project_id          = "org-bc-dev-data-01"
    folder_id           = "<folder-id-13>" # BC -> dev id
    auto_create_network = true
    billing_account     = "0165D9-2DF980-F799D0"
  },
  {
    name                = "org-bc-prod-data-01"
    project_id          = "org-bc-prod-data-01"
    folder_id           = "<folder-id-14>" # BC -> prod id
    auto_create_network = true
    billing_account     = "0165D9-2DF980-F799D0"
  },
  {
    name                = "org-data-science-dev-gemini-01"
    project_id          = "org-data-science-dev-gemini-01"
    folder_id           = "<folder-id-15>" # DSC -> prod id
    auto_create_network = true
    billing_account     = "0165D9-2DF980-F799D0"
  }

]
