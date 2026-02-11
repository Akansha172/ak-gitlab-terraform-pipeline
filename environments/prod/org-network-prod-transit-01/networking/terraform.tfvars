################
#  Project ID  #
################
project_id = "org-network-prod-transit-01"

#########
#  VPC  #
#########
vpc = {
  "org-vpc-prod-transit" = {
    routing_mode                    = "GLOBAL"
    auto_create_subnetworks         = false
    delete_default_routes_on_create = false
  }
}

############
#  Subnet  #
############
subnets = {
  "org-subnet-prod-transit-ue4" = {
    network_name          = "org-vpc-prod-transit"
    subnet_ip             = "<SUBNET_IP_RANGE>"
    subnet_region         = "us-east4"
    subnet_private_access = true
    description           = "Subnet for Transit VPC"
  },
  /*
  "org-subnet-prod-transit-uw1" = {
    network_name          = "org-vpc-prod-transit"
    subnet_ip             = "<SUBNET_IP_RANGE>"
    subnet_region         = "us-west1"
    subnet_private_access = true
    description           = "Subnet for Transit VPC"
  }
  */
}

#############################
#  PRIVATE SERVICE ACCESS  #
#############################
/* IF REQUIRED- Uncomment and fill in the values in below example
global_address = {
  "org-subnet-prod-transit-psc-ue4" = {
    vpc_name      = "https://www.googleapis.com/compute/v1/projects/org-network-prodtransit-01/global/networks/org-vpc-prod-transit"
    ipv4_address  = "example-range"
    address_type  = "INTERNAL"
    prefix_length = "24"
    purpose       = "VPC_PEERING"
    service       = "servicenetworking.googleapis.com"
  }
}
*/


###############
#  Cloud NAT  # 
###############
/* IF REQUIRED- Uncomment and fill in the values in below example
cloud_nat = {
  "org-nat-prod-transit-gcp-uw1" = {
    router_name                        = "example-router-1"
    region                             = "us-west1"
    nat_ip_allocate_option             = "AUTO_ONLY"
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  },
  "org-nat-prod-transit-gcp-ue4" = {
    router_name                        = "example-router-1"
    region                             = "us-east4"
    nat_ip_allocate_option             = "AUTO_ONLY"
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  }
}
*/

###################
#  Cloud Routers  #
###################
/* IF REQUIRED- Uncomment and fill in the values in below example
routers = {
  "cr-org-prod-example-uw1-01" = { # Example
    network                       = "org-vpc-prod-transit"
    region                        = "us-west1"
  }
}
*/