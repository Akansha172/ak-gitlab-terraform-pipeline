#########
#  VPC  #
#########
module "vpc" {
  source     = "../../../../modules/networking/vpc"
  project_id = var.project_id
  vpc        = var.vpc
}

############
#  Subnet  #
############
module "subnets" {
  source     = "../../../../modules/networking/subnets"
  project_id = var.project_id
  subnets    = var.subnets
  #secondary_ranges  = var.secondary_ranges

  depends_on = [module.vpc] # Ensuring VPCs are created first
}

############################
#  Private Service Access  #
############################
module "private_service_access" {
  source         = "../../../../modules/networking/private-service-access"
  project_id     = var.project_id
  global_address = var.global_address

  depends_on = [module.vpc] # Ensuring VPCs are created first
}

##################
# Cloud Router #
##################
module "routers" {
  source     = "../../../../modules/networking/cloud-router"
  project_id = var.project_id
  routers    = var.routers
  depends_on = [module.vpc] # Ensuring VPCs are created first
}

###############
#  Cloud NAT  #
###############
module "cloud-nat" {
  source = "../../../../modules/networking/cloud-nat"

  project_id = var.project_id
  cloud_nat  = var.cloud_nat
  depends_on = [module.vpc] # Ensuring VPCs are created first
}

