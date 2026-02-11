## 🔥 Firewall Rules Module

This module allows you to configure GCP firewall rules with full flexibility — including direction, logging, allow/deny blocks, and matching via source/target tags or service accounts.

## 🪣 Backend Configuration

This module stores its Terraform state remotely using **Google Cloud Storage (GCS)** for consistency and collaboration across teams.

```hcl
terraform {
  backend "gcs" {
    bucket = "org-bucket-prod-tfstate"
    prefix = "org-network-prod-01/firewall"
  }
}
```

## 🛠️ How to Use

- Define the `rules` variable in [`terraform.tfvars`](./terraform.tfvars) file.
- Each entry in the list represents a firewall rule and must include at least the `name` field.
- Use `direction`, `ranges`, `allow`/`deny`, `priority`, and other optional fields as needed for your configuration.
- The module automatically maps `ranges` to `source_ranges` (for `INGRESS`) or `destination_ranges` (for `EGRESS`).
- Refer to [`variables.tf`](./variables.tf) for all available options and defaults.


## ✅ Example 

```hcl
rules = [
  {
    name        = "fw-prod-ssh-iap"
    description = "SSH access via IAP"
    direction   = "INGRESS"
    priority    = "1001"

    ranges = [
      "35.235.240.0/20"
    ]

    allow = [
      {
        protocol = "tcp"
        ports    = ["22"]
      }
    ]
  },
  {
    name        = "fw-prod-health-check"
    description = "Allow GCP Health Check probes"
    direction   = "INGRESS"
    priority    = "1003"

    ranges = [
      "209.85.204.0/22",
      "209.85.152.0/22",
      "130.211.0.0/22",
      "35.191.0.0/16"
    ]

    allow = [
      {
        protocol = "tcp"
        ports    = ["0"]
      }
    ]
  }
]
```
### Direction-based Range Mapping

If the direction is set to `"INGRESS"`, the `ranges` provided will be applied as `source_ranges`.  
If the direction is `"EGRESS"`, the same `ranges` will be used as `destination_ranges`.

This ensures that IP CIDR blocks are mapped appropriately based on the traffic flow.

---

## 📚 References

- [📘 GCP Firewall Rules Documentation](https://cloud.google.com/vpc/docs/firewalls)
- [📘 Terraform: google_compute_firewall](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall)
- [📘 GCP Health Check IPs](https://cloud.google.com/load-balancing/docs/health-checks#ip-ranges)
- [📘 IAP TCP Forwarding](https://cloud.google.com/iap/docs/using-tcp-forwarding)

---

> ✅ Ensure required APIs (`compute.googleapis.com`) are enabled and IAM permissions are set for managing firewall rules (`roles/compute.securityAdmin`).
