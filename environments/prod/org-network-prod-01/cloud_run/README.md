# 🚀 Cloud Run Deployment in GCP

This configuration describes the setup for deploying services to **Cloud Run** in Google Cloud Platform using a container image. Multiple services will be deployed with the same image, with 100% of traffic directed to the latest revision.

---

## 🏗️ Project Information

All Cloud Run services are deployed under the following GCP project:

```hcl
project_id = "my-project-id"
```

---

## 🌍 Location

All services are deployed in the following region:

```hcl
location = "us-east4"
```

---

## 📦 Container Image

The image used for deploying all services:

```hcl
image = "gcr.io/cloud-run/hello"
```

Make sure the image is publicly accessible or stored within a registry that the project has access to.

---

## 🔧 Cloud Run Services

The following Cloud Run services are defined in the configuration:

```hcl
cloud_run_svc = ["svc1", "svc2"]
```

Each service will:
- Use the specified container image
- Be deployed in the specified region
- Receive **100% of traffic** on the latest deployed revision

---

## 📊 Traffic Allocation

```hcl
percent = 100
```

This value indicates that **100%** of incoming requests will be routed to the latest deployed revision of each service.

---

## 🛡️ Notes

- Ensure required APIs are enabled: `run.googleapis.com`
- IAM permissions must allow deploying and managing Cloud Run services (`roles/run.admin`, `roles/iam.serviceAccountUser`, etc.)
- Use environment-specific configurations if deploying across multiple environments (e.g., dev, staging, prod)

---

## 📚 References

- [📘 Cloud Run Documentation](https://cloud.google.com/run/docs)
- [📘 Deploying with Terraform](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service)
- [📘 Cloud Run Traffic Management](https://cloud.google.com/run/docs/deploying#routing-traffic)

---

Keep this README updated as services are added or deployment configurations change.