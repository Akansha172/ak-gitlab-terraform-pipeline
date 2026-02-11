# 🖥️ Virtual Machine (VM) Configuration in GCP

This configuration defines a production VM instance deployed on Google Cloud Platform (GCP), tailored for secure and scalable infrastructure management.

---

## 🏗️ Project and Location

The VM is provisioned in the following GCP project and region:

```hcl
project_id = "my-project-id"
region     = "us-east4"
zone       = "us-east4-a"
```

---

## 🔧 VM Configuration

```hcl
name                = "vm-prod-bastion"
machine_type        = "e2-medium"
image               = "ubuntu-2204-jammy-v20240701"
can_ip_forward      = false
deletion_protection = false
preemptible         = "false"
on_host_maintenance = "MIGRATE"
```

- **OS Image**: Ubuntu 22.04 LTS (`jammy`)
- **Type**: General-purpose `e2-medium`
- **Host Maintenance Policy**: `MIGRATE` (keep running on host updates)
- **Preemptible**: Disabled (set to `true` for cost-saving temporary workloads)

---

## 🗃️ Storage

```hcl
size = "50"
```

- 50 GB boot disk allocated to the VM.

---

## 🌐 Networking

```hcl
network            = "https://www.googleapis.com/compute/v1/projects/my-project-id/global/networks/vpc-prod"
subnetwork         = "https://www.googleapis.com/compute/v1/projects/my-project-id/regions/asia-south1/subnetworks/subnet-prod"
subnetwork_project = "my-project-id"
stack_type         = "IPV4_ONLY"
tags               = ["prod"]
```

- Connected to **vpc-prod** VPC and **subnet-prod** subnetwork.
- IPv4-only network stack.
- Tagged for production environment.

---

## 🔐 Identity and Permissions

```hcl
email  = "158450-compute@developer.gserviceaccount.com"
scopes = ["cloud-platform"]
```

- Associated with a service account with **full API access** (`cloud-platform` scope).

---

## 🏷️ Labels and Metadata

```hcl
labels = {
  env         = "prod",
  team        = "devops",
  deployed-by = "org"
}

metadata = {
  "enable-osconfig" = "TRUE"
}
```

- Metadata enables **OS Config** for agent management (required for Ops Agent).
- Labels provide environment and ownership context.

---

## 📚 References

- [📘 GCP VM Instances Documentation](https://cloud.google.com/compute/docs/instances)
- [📘 Compute Engine Image Families](https://cloud.google.com/compute/docs/images)
- [📘 OS Config Management](https://cloud.google.com/compute/docs/manage-os)

---

> ⚠️ **Note:** Ensure that required APIs like `compute.googleapis.com` are enabled and that the IAM permissions are correctly assigned to the service account before provisioning.