/*
Usage Guide:
- This module creates one or more Google Cloud firewall rules based on the list provided in the `rules` variable.
- Each rule can define direction (INGRESS/EGRESS), allowed or denied protocols/ports, source/destination CIDRs,
  tags or service accounts, and logging options.
- The `ranges` field dynamically maps to `source_ranges` or `destination_ranges` based on the direction.
- To use, provide required variables like `project_id`, `network_name`, and define your rules list.
- Refer to variables.tf for detailed descriptions and types of input variables.
*/

################
#  Project ID  #
################
project_id = "org-network-prod-01"

#################
#  VPC Network  #
#################
network_name = "https://www.googleapis.com/compute/v1/projects/org-network-prod-01/global/networks/org-vpc-prod"

####################
#  Firewall Rules  #
####################
rules = [
  {
    name        = "org-fw-prod-ssh-iap"
    description = "SSH access via IAP"
    direction   = "INGRESS"
    priority    = "1001"
    ranges      = ["35.235.240.0/20"]

    allow = [
      {
        protocol = "tcp"
        ports    = ["22"]
      }
    ]
  },
  {
    name        = "org-fw-prod-health-check"
    description = "Allow GCP Health Check probes"
    direction   = "INGRESS"
    priority    = "1003"
    ranges      = ["209.85.204.0/22", "209.85.152.0/22", "130.211.0.0/22", "35.191.0.0/16"]

    allow = [
      {
        protocol = "tcp"
        ports    = ["0"]
      }
    ]
  }
]
