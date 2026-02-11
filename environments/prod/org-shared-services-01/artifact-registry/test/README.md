# 📦 Artifact Registry Terraform Module

This module provisions one or more **Artifact Registry** repositories in a specified **Google Cloud Project** using Terraform.

---

## 🚀 What it does

- Creates Artifact Registry repositories in GCP.
- Supports setting repository ID, region, format (like DOCKER, MAVEN), and description.
- Allows managing multiple repositories across different environments or folders.

---

## 🪣 Backend Configuration

This module stores its Terraform state remotely using **Google Cloud Storage (GCS)** for consistency and collaboration.

```hcl
terraform {
  backend "gcs" {
    bucket = "org-bucket-prod-tfstate"
    prefix = "org-shared-services-01/artifact-registry/use-case"
  }
}
```
> 💡 **Tip:**  
> To create artifact registry for a different use case, update the `prefix` value in the `backend` block to reflect the new logical path.  
> For example, `artifact-registry/docker-apps` or `artifact-registry/java-apps` to isolate states for each use case.

---

## 🛠️ How to Use

- Define the `project_id` and `repositories` variables in your [`terraform.tfvars`](./terraform.tfvars) file.
- Each entry in `repositories` should have a unique key and specify required details like `location`, `repository_id`, and `format`.
- Refer to [`variables.tf`](./variables.tf) for all available options and defaults.

---

## ✅ Example

To add another Artifact Registry, add a new block in the `repositories` map with a unique `repository_id`.
- Here’s an example of how to define your repositories in Terraform:

```
project_id = "my-project-id"

repositories = {
  org-ar-prod-example-uw1 = {
    location      = "us-west1"
    repository_id = "org-ar-prod-example-uw1"
    description   = "Example repository"
    format        = "DOCKER"
  },
  org-ar-prod-apps-eu1 = {
    location      = "europe-west1"
    repository_id = "org-ar-prod-apps-eu1"
    description   = "Apps container registry"
    format        = "DOCKER"
  }
}
```
Ensure that the **Artifact Registry API** is enabled for target project.

## 📚 References

- [📘 GCP: Artifact Registry Documentation](https://cloud.google.com/artifact-registry/docs)
- [📘 Terraform: google_artifact_registry_repository](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository)
