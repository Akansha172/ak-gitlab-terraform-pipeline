# 📡 Enabling Required APIs in GCP

This configuration enables a list of essential Google Cloud APIs for your project. These APIs are necessary for provisioning and managing resources such as Compute Engine VMs, IAM policies, networking, and integrations with services like Kubernetes and Artifact Registry.

---

## 🏗️ Project Information

All APIs are enabled under the following GCP project:

```hcl
project_id = "my-project-id"
```

---

## ✅ APIs to Enable

The following APIs are required for infrastructure provisioning, monitoring, identity federation, and other core functionalities:

```hcl
api_list = [
  "compute.googleapis.com",                # Compute Engine (VMs, networks)
  "logging.googleapis.com",                # Cloud Logging
  "monitoring.googleapis.com",             # Cloud Monitoring
  "container.googleapis.com",              # Kubernetes Engine
  "artifactregistry.googleapis.com",       # Artifact Registry (Docker, Helm, etc.)
  "storage-component.googleapis.com",      # Cloud Storage (used internally)
  "iam.googleapis.com",                    # Identity and Access Management
  "cloudresourcemanager.googleapis.com",   # Project resource management
  "iamcredentials.googleapis.com",         # IAM credential management
  "sts.googleapis.com",                    # Security Token Service (WIF support)
  "servicenetworking.googleapis.com",      # Private service access
  "serviceusage.googleapis.com",           # API enablement & usage tracking
  "orgpolicy.googleapis.com"               # Organization policy service
]
```

---

## ⚙️ How It Works

Using Terraform or similar IaC tools, the above APIs are programmatically enabled for the specified GCP project. This ensures a consistent and reliable environment setup, particularly in automated or CI/CD-driven workflows.

---

## 📦 Common Use Cases

- 🖥️ Creating and managing virtual machines
- 🚀 Deploying workloads to GKE clusters
- 🔐 Managing IAM roles, policies, and identity federation
- 🧪 Enabling observability with logs and metrics
- 📦 Managing Docker images and Helm charts in Artifact Registry

---

## 📚 References

- [📘 GCP APIs & Services](https://cloud.google.com/apis)
- [📘 Terraform Google Provider: google_project_service](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service)

---

Feel free to customize the API list depending on your use case or environment setup.