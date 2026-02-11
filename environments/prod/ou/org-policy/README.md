# Google Organization Policy Terraform Module

This Terraform module helps manage Google Cloud Organization Policies at the organization, folder, or project level.

## ✅ Default Active Policies

The following org policies are enabled by default (`enforce = "TRUE"`) when using this module:

- iam.allowServiceAccountCredentialLifetimeExtension  
- resourcemanager.allowedExportDestinations  
- resourcemanager.allowedImportSources  
- cloudbuild.disableCreateDefaultServiceAccount  
- resourcemanager.allowEnabledServicesForExport  
- commerceorggovernance.marketplaceServices  
- appengine.runtimeDeploymentExemption  
- iam.serviceAccountKeyExposureResponse  
- compute.sharedReservationsOwnerProjects  
- cloudbuild.useComputeServiceAccount  
- cloudbuild.useBuildServiceAccoun  

## ⚙️ Policy Behavior with Terraform

- If a policy is created by Terraform and then destroyed:
  - If the policy was **inactive** before Terraform created it, it will return to **inactive**.
  - If the policy was **already active**, it will stay **active** after destruction.
- ✅ In short: Terraform will restore the previous state of the policy when it’s removed.

---

## 🪣 Backend Configuration

This module stores its Terraform state remotely using **Google Cloud Storage (GCS)** for consistency and collaboration.

```hcl
terraform {
  backend "gcs" {
    bucket = "org-bucket-prod-tfstate"
    prefix = "ou/org-polcy"
  }
}
```

---

## 🛠️ How to Use

To modify or add more policies, use the `org_policies` variable in [`terraform.tfvars`](./terraform.tfvars).
For folder or project-level policies, update the `name` field accordingly.  
Refer to [`variables.tf`](./variables.tf) for more details.

## ✅ Example

```hcl
example_policy = {
  name   = "organizations/743850070271/policies/constraint_name"
  parent = "organizations/743850070271"

  spec = {
    rules = [
      {
        condition = {
          description = "A sample condition for the policy"
          expression  = "resource.matchTagId('tagKeys/123', 'tagValues/345')"
          location    = "sample-location.log"
          title       = "sample-condition"
        }
        values = {
          allowed_values = ["projects/allowed-project"]
          denied_values  = ["projects/denied-project"]
        }
      },
      {
        allow_all = "TRUE"
      }
    ]
  }
}
```

---

## 📚 References

- [📘 GCP Org Policy Overview](https://cloud.google.com/resource-manager/docs/organization-policy/overview)  
- [📘 Terraform: google_org_policy_policy](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/org_policy_policy)  
