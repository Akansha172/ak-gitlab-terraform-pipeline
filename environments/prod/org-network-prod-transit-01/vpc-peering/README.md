# 🌐 Network Peering Module

This Terraform module allows you to create multiple Google Cloud VPC Network Peerings using a simple map-based input.


## ✅ Required Fields
- `name`: Name of the peering
- `network`: Primary VPC network (self)
- `peer_network`: The VPC network to peer with (can be from another project)

## ⚙️ Optional Fields
- `export_custom_routes`: Export custom routes (default: `false`)
- `import_custom_routes`: Import custom routes (default: `false`)
- `export_subnet_routes_with_public_ip`: Export subnet routes with public IPs (default: `true`)
- `import_subnet_routes_with_public_ip`: Import subnet routes with public IPs (default: `false`)
- `stack_type`: IP stack type allowed for peering (default: `IPV4_ONLY`). Possible values: `IPV4_ONLY`, `IPV4_IPV6`

## 🪣 Backend Configuration

This module stores its Terraform state remotely using **Google Cloud Storage (GCS)** for consistency and collaboration.

```hcl
terraform {
  backend "gcs" {
    bucket = "org-bucket-prod-tfstate"
    prefix = "org-network-prod-transit-01/vpc-peering"
  }
}
```

## 🛠️ How to Use

- Define the `peerings` variable as a map where each key is a unique peering name and the value is an object describing the peering configuration in [`terraform.tfvars`](./terraform.tfvars).
- Supports optional fields with sensible defaults (see [`variables.tf`](./variables.tf) for full reference).
- For full bi-directional communication, ensure peerings are declared **in both directions** (e.g., `vpc1-to-vpc2` and `vpc2-to-vpc1`).

> ✅ IAM permissions are required for both networks involved in the peering.

## ✅ Example

Define the `peerings` variable as a map. Each key represents a unique peering connection between two networks:

```hcl
peerings = {
  "vpc1-to-vpc2" = {
    name         = "vpc1-to-vpc2"
    network      = "projects/my-project/global/networks/vpc1"
    peer_network = "projects/my-project/global/networks/vpc2"

    export_custom_routes                = true
    import_custom_routes                = true
    export_subnet_routes_with_public_ip = true
    import_subnet_routes_with_public_ip = true
    stack_type                          = "IPV4_ONLY"
  }

  "vpc2-to-vpc1" = {
    name         = "vpc2-to-vpc1"
    network      = "projects/my-project/global/networks/vpc2"
    peer_network = "projects/my-project/global/networks/vpc1"
    # Uses default values for optional fields
  }
}
```

---

## 📚 References

- [📘 GCP: VPC Network Peering Overview](https://cloud.google.com/vpc/docs/vpc-peering)
- [📘 Terraform: google_compute_network_peering](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network_peering)
