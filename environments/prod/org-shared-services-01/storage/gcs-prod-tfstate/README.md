# 🪣 GCS Buckets Module
This Terraform module provisions **multiple Google Cloud Storage (GCS) buckets** using a single map input.

## 🚀 What it does

- Creates GCS buckets with customizable options:
  - Location
  - Storage class
  - Labels
  - Versioning
  - Retention policies
  - Lifecycle management rules
  - Public access prevention
  - Autoclass
- Supports complex lifecycle management rules such as auto-deleting noncurrent versions, transitioning storage class, and more.

## 🪣 Backend Configuration

This module stores its Terraform state remotely using **Google Cloud Storage (GCS)** for consistency and collaboration.

```hcl
terraform {
  backend "gcs" {
    bucket = "org-bucket-prod-tfstate"
    prefix = "org-shared-services-01/storage/gcs-prod-tfstate"
  }
}
```

> 💡 **Tip:**  
> To manage Terraform state for another GCS use case, update the `prefix` value to reflect a new logical grouping.  
> Examples:
> - `storage/gcs-logs` for logging-related buckets  
> - `storage/gcs-backups` for backup buckets  
> - `storage/data-ingestion` for staging raw data  
> This ensures isolation of state files per purpose or environment.

## 🛠️ How to Use

- Define the `buckets` variable as a map where each key is a unique bucket identifier and the value is an object describing the bucket configuration in [`terraform.tfvars`](./terraform.tfvars).
- Supports optional fields with sensible defaults (see [`variables.tf`](./variables.tf) for full reference).

## ✅ Example

```hcl
buckets = {
  "org-bucket-dev-example" = {
    name       = "org-bucket-dev-example"
    project_id = "my-project-id"
    location   = "us-west1"
    lifecycle_rules = [
      {
        action = { type = "Delete" }
        condition = {
          num_newer_versions = 2
          with_state         = "ARCHIVED"
          is_live            = false
        }
      }
    ]
  }
}
```

> ✅ For all configurable options and default values, refer to the [`variables.tf`](./variables.tf) in this module.

---

## 📚 References

- [📘 GCP: Cloud Storage Buckets Overview](https://cloud.google.com/storage/docs/creating-buckets)  
- [📘 Terraform: google_storage_bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket)  
