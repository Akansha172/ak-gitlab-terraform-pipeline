##################
#  VPC peerings  # 
##################
module "vpc-peering" {
  source   = "../../../../modules/networking/vpc-peering"
  peerings = var.peerings
}
