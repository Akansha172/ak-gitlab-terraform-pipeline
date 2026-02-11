# 🌐 GCP Network Infrastructure

This configuration defines the Virtual Private Cloud (VPC), subnets, private service access, Cloud Routers, and Cloud NAT for the `my-project-id` project in Google Cloud Platform (GCP).

---

## 🏗️ Project

```hcl
project_id = "my-project-id"
```

---

## 🧭 VPC Configuration

```hcl
vpc = {
  "vpc-prod" = {
    routing_mode                    = "GLOBAL"
    auto_create_subnetworks         = false
    delete_default_routes_on_create = false
  }
}
```

- **Routing Mode**: Global
- **Auto Subnet Creation**: Disabled
- **Default Routes**: Preserved

---

## 📍 Subnetworks

Two subnets are defined for different regions:

```hcl
subnets = {
  "subnet-prod-app-uw1" = {
    subnet_region         = "us-west1"
    subnet_ip             = "10.0.3.0/24"
    subnet_private_access = true
    description           = "Application Subnet"
  },
  "subnet-prod-app-ue4" = {
    subnet_region         = "us-east4"
    subnet_ip             = "10.0.2.0/24"
    subnet_private_access = true
    description           = "Application Subnet"
  }
}
```

- Private Google access enabled for both subnets
- Part of the same `vpc-prod` VPC

---

## 🔁 Private Service Access

Private Service Access allows integration with GCP-managed services over internal IP.

```hcl
global_address = {
  "subnet-prod-psc-ue4" = {
    ipv4_address  = "10.0.1.0"
    prefix_length = "24"
    address_type  = "INTERNAL"
    purpose       = "VPC_PEERING"
    service       = "servicenetworking.googleapis.com"
  }
}
```

- Enables private connectivity to Google services via VPC Peering

---

## 🚦 Cloud Routers

Routers for dynamic route management in each region:

```hcl
routers = {
  "router-prod-gcp-uw1" = {
    region  = "us-west1"
  },
  "router-prod-gcp-ue4" = {
    region  = "us-east4"
  }
}
```

Each router is associated with the `vpc-prod` VPC.

---

## 🌐 Cloud NAT

Cloud NAT configuration provides internet access for private instances:

```hcl
cloud_nat = {
  "nat-prod-gcp-uw1" = {
    router_name = "router-prod-gcp-uw1"
    region      = "us-west1"
    nat_ip_allocate_option = "AUTO_ONLY"
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  },
  "nat-prod-gcp-ue4" = {
    router_name = "router-prod-gcp-ue4"
    region      = "us-east4"
    nat_ip_allocate_option = "AUTO_ONLY"
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  }
}
```

- Auto-allocates NAT IPs
- Applies to all subnets in respective regions

---

## ✅ Summary

This configuration sets up a secure, multi-region network environment with:
- Centralized VPC (`vpc-prod`)
- Application subnets in `us-west1` and `us-east4`
- Private Service Access for internal connectivity
- Cloud Routers and NATs for dynamic routing and outbound internet

---

## 📚 References

- [📘 VPC Documentation](https://cloud.google.com/vpc/docs)
- [📘 Private Google Access](https://cloud.google.com/vpc/docs/private-google-access)
- [📘 Cloud NAT](https://cloud.google.com/nat/docs)
- [📘 Cloud Router](https://cloud.google.com/hybrid-connectivity/docs/router/how-to/creating-routers)

---

> 🔐 Ensure proper IAM permissions and API enablement (`compute.googleapis.com`, `servicenetworking.googleapis.com`) before provisioning.