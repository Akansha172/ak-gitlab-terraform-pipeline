# 📁 GCP Folders Module

This Terraform module provisions **GCP folders** in a hierarchical structure under Organization.

---

## 🚀 What it does

- Creates folders in your GCP organization using Terraform.
- Supports nested folder structures by specifying parent folder IDs.
- Enables optional tagging (`labels`) for organizational, billing, and identification purposes.

---

## 🪣 Backend Configuration

This module stores its Terraform state remotely using **Google Cloud Storage (GCS)** for consistency and collaboration.

```hcl
terraform {
  backend "gcs" {
    bucket = "org-bucket-prod-tfstate"
    prefix = "ou/gcp-folder"
  }
}
```

---
## 🛠️ How to use

- Define the `folders` variable as a list of objects in [`terraform.tfvars`](./terraform.tfvars).
- Each object must include:
  - `name`: Name of the folder (e.g., "Dev", "Shared Services").
  - `parent`: The parent resource.
    - Use `organizations/<org_id>` for top-level folders.
    - Use `folders/<folder_id>` for child folders.
  - `tags` *(optional)*: Key-value map for folder labels.
- Create parent folders **before** their children.

---

## ✅ Example

```hcl
folders = [
  {
    name   = "Landing Zone"
    parent = "organizations/123456789"
  },
  {
    name   = "Infrastructure"
    parent = "folders/111111111111" # Replace with actual ID of "Landing Zone"
  },
  {
    name   = "Shared Services"
    parent = "folders/222222222222" # Replace with actual ID of "Infrastructure"
    tags   = {
      environment = "prod"
      owner       = "platform-team"
    }
  }
]
```

---

> ✅ For full details on available inputs and structure, refer to the [`variables.tf`](./variables.tf) file in this module.

---

## 📚 References

- 📘 [GCP: Creating and Managing Folders](https://cloud.google.com/resource-manager/docs/creating-managing-folders)
- 📘 [Terraform Google Provider: google_folder Resource](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_folder)
