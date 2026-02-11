################
#  Project ID  #
################
project_id = "org-network-prod-01"

#########
#  VPC  #
#########
vpc = {
  "org-vpc-prod" = {
    routing_mode                    = "GLOBAL"
    auto_create_subnetworks         = false
    delete_default_routes_on_create = false
  }
}

############
#  Subnet  #
############
subnets = {
  "org-subnet-prod-app-uw1" = {
    network_name          = "org-vpc-prod"
    subnet_ip             = "<SUBNET_IP_RANGE>"
    subnet_region         = "us-west1"
    subnet_private_access = true
    description           = "Application Subnet"
  }
  "org-subnet-prod-app-ue4" = {
    network_name          = "org-vpc-prod"
    subnet_ip             = "<SUBNET_IP_RANGE>"
    subnet_region         = "us-east4"
    subnet_private_access = true
    description           = "Application Subnet"
  }
}

#############################
#  PRIVATE SERVICE ACCESS  #
#############################
global_address = {
  "org-subnet-prod-psc-ue4" = {
    vpc_name      = "https://www.googleapis.com/compute/v1/projects/org-network-prod-01/global/networks/org-vpc-prod"
    ipv4_address  = "<PRIVATE_SERVICE_ACCESS_IP>"
    address_type  = "INTERNAL"
    prefix_length = "24"
    purpose       = "VPC_PEERING"
    service       = "servicenetworking.googleapis.com"
  }
}

###################
#  Cloud Routers  #
###################
routers = {
  "cr-org-prod-gcp-uw1" = {
    network = "org-vpc-prod"
    region  = "us-west1"
  },
  "cr-org-prod-gcp-ue4" = {
    network = "org-vpc-prod"
    region  = "us-east4"
  }
}

###############
#  Cloud NAT  # 
###############
cloud_nat = {
  "org-nat-prod-gcp-uw1" = {
    router_name                        = "cr-org-prod-gcp-uw1"
    region                             = "us-west1"
    nat_ip_allocate_option             = "AUTO_ONLY"
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  },
  "org-nat-prod-gcp-ue4" = {
    router_name                        = "cr-org-prod-gcp-ue4"
    region                             = "us-east4"
    nat_ip_allocate_option             = "AUTO_ONLY"
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  }
}