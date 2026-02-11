# 📁 GCP Projects Module

This Terraform module provisions **multiple Google Cloud Projects** with flexible options for billing, folder placement, networking, and tagging.

---

## 🚀 What It Does

- Creates GCP projects under the specified **organization** or **folders**
- Optionally links **billing accounts** to the projects
- Supports custom **tags/labels** for metadata, billing, or organization
- Optionally enables or disables creation of the **default VPC network**

---

## 🪣 Backend Configuration

This module stores its Terraform state remotely using **Google Cloud Storage (GCS)** for consistency and collaboration.

```hcl
terraform {
  backend "gcs" {
    bucket = "org-bucket-prod-tfstate"
    prefix = "ou/gcp-project"
  }
}
```

---

## 🛠️ How to Use

- Define a list of project configurations using the `projects` variable in [`terraform.tfvars`](./terraform.tfvars).
- Each project object must include:
  - `name`: Display name for the project
  - `project_id`: Globally unique identifier for the project

- Optionally include:
  - `billing_account`: Billing account ID to attach
  - `org_id`: If not using folders, specify the organization ID
  - `folder_id`: Folder ID to place the project under (recommended)
  - `auto_create_network`: Set to `true` to create a default VPC
  - `tags`: Labels for organizing, identification, or billing

---

## ✅ Example

```hcl
projects = [
  {
    name                = "org-env-example-01"
    project_id          = "org-env-example-01"
    folder_id           = "folders/123456789"   # Replace with actual folder ID
    auto_create_network = true
    billing_account     = "AAAAAA-BBBBBB-CCCCCC" # Replace with your billing account ID
  },
  {
    name                = "org-env-example-02"
    project_id          = "org-env-example-02"
    folder_id           = "folders/987654321"   # Replace with actual folder ID
    auto_create_network = true
    billing_account     = "AAAAAA-BBBBBB-CCCCCC"
  },
  ...
]
```

---

## 📚 References

- 📘 [GCP: Creating and Managing Projects](https://cloud.google.com/resource-manager/docs/creating-managing-projects)
- 📘 [Terraform Google Provider: google_project Resource](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project)
