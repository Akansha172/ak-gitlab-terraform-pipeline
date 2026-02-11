# Workload Identity Federation (WIF) in GCP

This configuration sets up Workload Identity Federation in Google Cloud Platform (GCP) to enable secure, short-lived authentication from external identities—specifically GitLab in this case.
- A Workload Identity Pool acts as a trust boundary for external identities. Here, we define a single pool to group trusted identities from GitLab:
- Workload Identity Providers (WIPs) are created under the pools to define how identities from a specific external system (e.g., GitLab) are mapped and trusted.

---

## 🔄 Use Case

This setup allows CI/CD pipelines in GitLab (`repo/example.repositories`) to impersonate GCP service accounts without the need for long-lived credentials, using short-lived, scoped tokens issued via Workload Identity Federation.

---

## ✅ Benefits

- 🔐 **Improved Security**: No service account keys.
- 🔄 **Dynamic Auth**: Federated tokens with specific conditions.

---

## 🛠️ How to Use

- Define the `pools` and `identity_providers` variables inside [`terraform.tfvars`](./terraform.tfvars).
- Each `identity_provider` must be mapped to a corresponding `pool_name`.
- Set `attribute_mapping` and `attribute_condition` based on your GitLab or other external identity provider setup.
- Refer to [`variables.tf`](./variables.tf) for supported structure and default values.

## 🪣 Backend Configuration

This module stores its Terraform state remotely using **Google Cloud Storage (GCS)** for consistency and collaboration.

```hcl
terraform {
  backend "gcs" {
    bucket = "org-bucket-prod-tfstate"
    prefix = "org-shared-services-01/iam/workload-identity-federation/gitlab"
  }
}
```
---

> 💡 Tips
> To configure WIF for another GitLab project or trust boundary, update the `prefix` path to reflect the logical grouping.
> For example, `workload-identity-federation/gitlab-dev`, `workload-identity-federation/github-prod`, etc., to isolate environments.


## ✅ Example :

#### GCP Project
```hcl
project_id = "my-project-id"
```

---

#### Workload Identity Pools
```hcl
pools = [
  "wif-pool-gitlab"
]
```

---

#### Workload Identity Providers
```hcl
identity_providers = {
  "org-wif-provider-prod-gitlab" = {
    pool_name           = "wif-pool-gitlab"
    url                 = "https://gitlab.com"
    attribute_condition = "assertion.project_path == 'repo/example.repositories'"

    attribute_mapping = {
      "google.subject"           = "assertion.sub"
      "attribute.aud"            = "assertion.aud"
      "attribute.project_path"   = "assertion.project_path"
      "attribute.project_id"     = "assertion.project_id"
      "attribute.namespace_id"   = "assertion.namespace_id"
      "attribute.namespace_path" = "assertion.namespace_path"
      "attribute.user_email"     = "assertion.user_email"
      "attribute.ref"            = "assertion.ref"
      "attribute.ref_type"       = "assertion.ref_type"
    }
  }
}
```
#### Attribute Mapping and Conditions

Above **assertion** fields will be mapped with GCP attributes. Based on **attribute_condition** only tokens originating from the specific attribute will be trusted by the provider.

---

## 📚 References

- [📘 GCP: Workload Identity Federation Docs](https://cloud.google.com/iam/docs/workload-identity-federation)  
- [📘 GitLab: OpenID Connect Integration](https://docs.gitlab.com/ee/ci/cloud_services/)
- [📘 Terraform: google_iam_workload_identity_pool](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool)  
- [📘 Terraform: google_iam_workload_identity_pool_provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool_provider)