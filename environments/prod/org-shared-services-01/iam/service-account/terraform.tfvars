####################################
#  Service Account and IAM Roles   #
####################################
service_accounts = [
  {
    project_id   = "org-shared-services-01"
    account_id   = "org-sa-tf-gitlab"
    display_name = "Gitlab WIF Service Account"
    description  = "Service Account for impersonation by Gitlab Workload Identity Pool"
    org_roles = [
      {
        org_id = "<org-id>"
        roles = ["roles/artifactregistry.admin",
          "roles/storage.admin",                     # Create and manage storage(GCS) resources
          "roles/compute.admin",                     # Create and manage Compute Resources
          "roles/resourcemanager.organizationAdmin", # Create and manage org level IAM, sub-folders or projects
          "roles/resourcemanager.projectCreator",    # Create and manage GCP projects
          "roles/storage.folderAdmin",               # Create and manage GCP folders
          "roles/serviceusage.serviceUsageAdmin",    # Enable and manage GCP APIs
          "roles/orgpolicy.policyAdmin"              # Create and manage Organization Policies
        ]
      }
    ]
    folder_roles = [
      {
        folder = "folders/<folder-id-1>"  # Landing zone id
        roles  = ["roles/storage.admin"] # Example 
      }
    ]
    project_roles = [
      {
        project = "org-shared-services-01"
        roles = ["roles/iam.workloadIdentityPoolAdmin", # Manage WIF
          "roles/iam.serviceAccountAdmin",              # Manage SA
          "roles/storage.objectAdmin",                  # Access tfstate buckets
          "roles/storage.objectViewer",                 # Access tfstate buckets
          "roles/storage.objectUser"                    # Access tfstate buckets
        ]
      }
    ]
    service_account_members = [
      # To grant access for other Gitlab Project, replace myteam/myorg-terraform with respective project path
      {
        role   = "roles/iam.workloadIdentityUser" # Service Account Impersonation for WIF
        member = "principalSet://iam.googleapis.com/projects/<project-number>/locations/global/workloadIdentityPools/org-wif-pool-prod-gitlab/attribute.project_path/myteam/myorg-tf-new"
      },
      {
        role   = "roles/iam.serviceAccountTokenCreator" # Create tokens, needed for WIF
        member = "principalSet://iam.googleapis.com/projects/<project-number>/locations/global/workloadIdentityPools/org-wif-pool-prod-gitlab/attribute.project_path/myteam/myorg-tf-new"
      }
    ]
  }
]
