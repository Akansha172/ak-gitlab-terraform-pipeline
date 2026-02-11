# 📦 Terraform Structure & State Management

This repository follows a scalable structure with isolated environments (`dev`, `prod`), organized directories, reusable modules, and GCS-backed state files.

## 📁 Branch-to-Environment Mapping

| Branch         | Path                        |
|----------------|-----------------------------|
| `master-dev`   | `environments/dev/`         |
| `master-prod`  | `environments/prod/`        |

## 📁 Directory Structure


### 🧭 `environments/`

Contains environment-specific infrastructure, separated as:

```
environments/
  ├── dev/                  # Development environment (only in master-dev branch)
  │   ├── <project-name-1>/     # Example: org-network-dev-01
  │   │   ├── iam/
  │   │   ├── networking/
  │   │   └── ...
  │   └── <project-name-N>/
  │       └── ...
  │
  └── prod/                # Production environment (only in master-prod branch)
      ├── <project-name-1>/     # Example: org-network-prod-01
      │   ├── apis/
      │   ├── firewall/
      │   ├── networking/
      │   └── ...
      │
      ├── <project-name-2>/     # Example: org-shared-services-01
      │   ├── artifact-registry/
      │   ├── iam/
      │   ├── storage/
      │   └── ...
      │
      ├── <project-name-3>/     # Example: org-network-prod-transit-01
      │   ├── networking/
      │   └── vpc-peering/
      │
      └── ou/                   # Org-level configs
          ├── gcp-folder/
          ├── gcp-project/
          └── org-policy/
```

🧾 **Legend:**
- `<project-name-X>/` → Individual projects like `org-network-prod-01`, `org-shared-services-01`, etc.
- Resource folders (`networking/`, `iam/`, `firewall/`, etc.) are defined within each project as per its scope.

---

### 🧱 modules/
Reusable Terraform modules used across all environments and projects:
- `apis/` → GCP API enablement
- `artifact-registry/` → Artifact Registry infra
- `iam/` → IAM bindings, custom roles, service accounts
- `networking/` → VPC, subnets, firewalls, routes, NAT, etc.
- `ou/` → Modules to manage folders, org-level configs
- `storage/` → Buckets, lifecycle rules, 

---

### 🛠️ CI/CD Files
- `.gitlab-ci.yml` → Primary pipeline config
- `.apply-ci.yml` → Apply-only flow (approval driven)
- `.gitignore` → Ignored files/folders
- `README.md` → Project documentation

---

📌 *This folder layout ensures clean separation between environments, logical grouping of resources, and maximum reuse through modularization.*


## ☁️ Terraform State Storage – GCS Buckets

Terraform state is stored in GCS buckets under the shared services project `org-shared-services`. Separate buckets are maintained for `dev` and `prod`.
  - 🪣 GCS Bucket: `org-bucket-dev-tfstate` -> For `master-dev` branch
  - 🪣 GCS Bucket: `org-bucket-prod-tfstate` -> For `master-prod` branch

### ⚙️ State Structure
```
<gcs-bucket-name>/                --> org-bucket-dev-tfstate or org-bucket-prod-tfstate
  <project-name-1>/               --> Project-level segregation, e.g. org-network-prod-01, org-shared-services-01
    <resource-group-1>/           --> (e.g., networking, iam, compute)
    <resource-group-2>/
    ...
  <project-name-2>/
    <resource-group-1>/
    <resource-group-2>/
    ...
  ou/                             --> Org level units stored in prod bucket org-bucket-prod-tfstate
    gcp-folder/
    gcp-project/
    org-policy/
```

## 🧑‍💻 How to Use

- Navigate to the respective environment and project folder inside `environments/`:
  - Example: `environments/dev/project-1/iam` or `environments/prod/project-2/compute/`

- Edit or add variables in the `terraform.tfvars` file as per your requirement.

- For detailed information:
  - 📘 Refer to the `README.md` present inside each subfolder.
  - 💬 Inline comments are added in the Terraform `.tf` files to help you understand the purpose of each block.


## 🧠 Summary

- Environments are mapped to Git branches (`master-dev`, `master-prod`).
- Directory structure reflects real-world resource segregation.
- State is split by project/module in GCS for isolation and better lifecycle control.
- Reusable modules are placed under the top-level `modules/` folder.


---

# 🛠️ Terraform GitLab CI/CD Pipeline

This repository contains a GitLab CI/CD pipeline for safely and securely deploying Terraform configurations to Google Cloud Platform (GCP) environments (`dev` and `prod`) using Workload Identity Federation (WIF).


## 🧰 Features

- 🛠️ **Multi-directory Terraform support** – runs against all `.tf` directories.
- 🔒 **Secure GCP Authentication** – using Workload Identity Federation (no secrets needed).
- ✅ **Safe Apply & Manual Gates** – plan must detect changes, and approvals are required to apply.
- 🧾 **Detailed Change Reports** – `report.txt` generated with resource counts.
- ☠️ **Destroy Detection & Manual Control** – warns and blocks any destroy plan unless explicitly approved.


## ☁️ GCP Authentication – Workload Identity Federation

Instead of storing GCP credentials, this pipeline impersonates a GCP service account using OpenID Connect (OIDC).  
A `.jwt` token is passed to GCP via a temporary config file:

```json
{
  "type": "external_account",
  "audience": "//iam.googleapis.com/projects/<PROJECT_NUMBER>/locations/global/workloadIdentityPools/<POOL_ID>/providers/<PROVIDER_ID>",
  "subject_token_type": "urn:ietf:params:oauth:token-type:jwt",
  "token_url": "https://sts.googleapis.com/v1/token",
  ...
}
```

## 🧠 Environment Variables

| Variable                          | Purpose                                                              |
|-----------------------------------|----------------------------------------------------------------------|
| `TF_VERSION`                      | Terraform version to use                                             |
| `TF_TARGET_DIR`                   | Terraform Target Dir to check for .tf files(dynamic based on branch) |
| `WORKLOAD_IDENTITY_*`             | WIF config values for GCP authentication                             |
| `SERVICE_ACCOUNT`                 | Target GCP service account to impersonate                            |
| `GOOGLE_APPLICATION_CREDENTIALS`  | Temporary file path for auth config                                  |


## 🧪 Pipeline (`.gitlab-ci.yaml`)


### 🌐 Global Config

#### 🔀 Branch-Based Targeting
- The pipeline sets the Terraform target directory based on the branch:
  - If branch = `master-prod` → Target: `environments/prod`
  - If branch = `master-dev` → Target: `environments/dev`


#### 🖼️ Image
- **Image**: `hashicorp/terraform:$TF_VERSION`  
  (Set terraform version using variable `TF_VERSION`, currently set to `"1.11.0"`)


#### 🗃️ Cache
- `.terraform`, `.terraform.lock.hcl` files are cached  
  (avoids repeating `terraform init` in further stages)


#### 🕒 When the pipeline runs
- Triggered on changes to `.tf`, `.tfvars`, and CI configuration files

---

### 🛣️ Stages - 


#### 1️⃣ `init-validate`
- **What it does**: Runs `terraform fmt`, `terraform init`, and `terraform validate` on all subdirectories.
- **Auth**: Authenticates using WIF


#### 2️⃣ `plan`
- **Auth**: Authenticates using WIF
- **What it does**: Runs `terraform plan` across all directories and generates summary and report based on plan.
- **Detects**: 
  - Resource additions 🟢
  - Modifications 🟡
  - Deletions 🔴
- **Output**:
  - In respective sub-folder:
    - `tfplan` (binary plan)
    - `tfplan.json` (JSON representation)
    - `tfplan.txt` (summary of changes)
    - `output.txt` (CLI Output of plan)
  - In `TF_TARGET_DIR`:
    - `report.txt` (human-readable summary)
    - `changed_dirs.txt` (list of changed directories)
- **Env Output**:
  - `CI_CHANGE=true|false`
  - `DESTROYING=true|false`


#### 3️⃣ `check_changes`
- **What it does**: Triggers downstream apply pipeline (`.apply-ci.yml`) and passes down required Environment Variables.

---

### 🔁 Apply Pipeline Stages (`.apply-ci.yml`)

#### 4️⃣ `apply_destroy`
- **When it runs**: Only when a **destroy** is detected.
- **Manual Gate**: Requires `APPLY_DESTROY=true` to approve the destroy.
- **What it does**: Waits for manual approval by checking `APPLY_DESTROY=true` and handles any other values of APPLY_DESTROY.


#### 5️⃣ `apply`
- **Auth**: Re-authenticates using WIF
- **Manual Gate**: Requires `APPLY=true` to approve apply. 
- **What it does**: 
  - Requires `APPLY_DESTROY=true` to be given in earlier stage if destroy is detected. Shows warning if apply is approved but destroy wasn't approved. Handles any other values of APPLY
  - Runs `terraform apply` across all changed directories.
  - The Terraform apply step follows a specific order to respect dependencies between resources:
    - 🥇 **Top Priority**
      - `ou/gcp-folder/` → Organization folder setup
      - `ou/gcp-project/` → Project-level configurations

    - 🥈 **Mid Priority (in order)**
      - All remaining `ou/` directories
      - `networking/` → VPCs, firewalls, subnets
      - `iam/` → IAM bindings and roles
      - `storage/` → Buckets, disks
      - `compute/` → VMs, MIGs, templates

    - 🥉 **Last**
      - Any other modules or resources not listed above  
        _Example_: `logging/`, `monitoring/`, `cloudsql/`, `pubsub/`, etc.

  - This ensures that foundational resources like folders, projects, and networks are applied before dependent components like VMs and IAM roles.


#### 6️⃣ `apply_skipped`
- Reserved for scenarios where `apply` is skipped when there are no changes detected in plan 

#### 7️⃣ `apply_invalid`
- Reserved for scenarios where `apply` is invalid due to incorrect variable configuration 

## 🚦 Safe Deployment Tips

- Always review `report.txt` before approving any apply.
- Never blindly approve `apply_destroy` without reviewing the impact.


## ✅ Approval Flow

- `terraform plan` detects changes.
- If **destroy** is included:
  - Requires `APPLY_DESTROY=true` in the `apply_destroy` job.
  - Requires `APPLY=true` in the `apply` job.
- If **changes** exist:
  - Requires `APPLY=true` in the `apply` job.
- **Manual approvals** are mandatory to run apply steps.


## 📦 Artifacts Produced in Plan Stage

| File                  | Description                                      |
|-----------------------|--------------------------------------------------|
| `tfplan`              | Terraform binary plan                            |
| `tfplan.json`         | JSON representation of the plan                  |
| `tfplan.txt`          | Summary of adds/changes/destroys                 |
| `report.txt`          | Final human-readable report                      |
| `output.txt`          | Output of terraform commands                     |
| `changed_dirs.txt`    | List of affected directories                     |
| `.terraform`          | Cached provider/module info                      |
| `.terraform.lock.hcl` | Lock file to ensure provider versions            |


---
