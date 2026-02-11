# 🔐 Service Account Module

This Terraform module:

- Creates a Google Cloud **Service Account**
- Assigns IAM roles at multiple levels:
  - **Organization level**
  - **Folder level**
  - **Project level**
- Supports binding external identities (e.g., GitLab Workload Identity Pools) for use cases like - SA impersonation, Token generation via Workload Identity Federation

---

## 🪣 Backend Configuration

This module stores its Terraform state remotely using **Google Cloud Storage (GCS)** for consistency and collaboration.

```hcl
terraform {
  backend "gcs" {
    bucket = "org-bucket-prod-tfstate"
    prefix = "org-shared-services-01/iam/service-account"
  }
}
```
---
## 🛠️ How to Use

To create service accounts and assign IAM roles at various levels (organization, folder, or project), use the `service_accounts` variable and provide the necessary details for each level in [`terraform.tfvars`](./terraform.tfvars).

- **Required fields**: `project_id` and `account_id`.
- **Optional**: `display_name`, `description`, and `disabled`.
- Define IAM role bindings by specifying:
  - `org_roles` for organization-level roles
  - `folder_roles` for folder-level roles
  - `project_roles` for project-level roles
- To bind external identities (e.g., from GitHub or GitLab using Workload Identity Federation), use `service_account_members`.

📌 See the example below for typical usage with all supported role bindings and external identity configuration. Check [`variables.tf`](./variables.tf) in this module for details.

---

## ✅ Example Usage

```hcl
service_accounts = [
  {
    project_id   = "my-project-id"
    account_id   = "example-sa"
    display_name = "Example Service Account"
    description  = "Used for CI/CD pipeline impersonation"

    org_roles = [
      {
        org_id = "123456789012"
        roles = [
          "roles/resourcemanager.organizationViewer",
          "roles/orgpolicy.policyViewer"
        ]
      }
    ]

    folder_roles = [
      {
        folder = "folders/123456789012"
        roles  = ["roles/resourcemanager.folderViewer"]
      }
    ]

    project_roles = [
      {
        project = "my-project-id"
        roles = [
          "roles/iam.serviceAccountUser",
          "roles/storage.objectViewer"
        ]
      }
    ]

    service_account_members = [
      {
        role   = "roles/iam.workloadIdentityUser"
        member = "principalSet://iam.googleapis.com/projects/123456789012/locations/global/workloadIdentityPools/example-pool/attribute.project_path/my-org/my-repo"
      }
    ]
  }
]
```

---

## 📚 References

- 📘 [GCP: Creating and Managing Service Accounts](https://cloud.google.com/iam/docs/creating-managing-service-accounts)  
- 📘 [Terraform: google_service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account)  
- 📘 [Terraform: google_project_iam_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam)  
- 📘 [Terraform: google_organization_iam_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_organization_iam)  
- 📘 [Terraform: google_folder_iam_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_folder_iam)  
- 📘 [Workload Identity Federation (WIF) Overview](https://cloud.google.com/iam/docs/workload-identity-federation)
