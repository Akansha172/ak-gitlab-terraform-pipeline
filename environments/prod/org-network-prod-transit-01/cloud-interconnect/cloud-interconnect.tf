##################
# Cloud Router #
##################
module "routers" {
  source     = "../../../../modules/networking/cloud-router"
  project_id = var.project_id
  routers    = var.routers
}

##################################
# Interconnect Vlan Attachment  #
##################################
module "cloud_interconnect_attachment" {
  source                   = "../../../../modules/networking/cloud-interconnect/vlan-attachment"
  project_id               = var.project_id
  interconnect_attachments = var.interconnect_attachments
  depends_on               = [module.routers] # Ensuring routers are created first
}


#######################
#  Router Interfaces  #
#######################
module "router_interfaces" {
  source            = "../../../../modules/networking/cloud-vpn/router-interfaces"
  project_id        = var.project_id
  router_interfaces = var.router_interfaces
  depends_on        = [module.routers] # Ensuring routers are created first
}

##################
#  Router Peers  #
##################
module "router_peers" {
  source       = "../../../../modules/networking/cloud-vpn/router-peers"
  project_id   = var.project_id
  router_peers = var.router_peers
  depends_on   = [module.routers, module.router_interfaces] # Ensuring routers and interfaces are created first
}

####################
#  HA VPN Gateways #
####################
module "ha_vpn_gateways" {
  source          = "../../../../modules/networking/cloud-vpn/ha-vpn-gateway"
  project_id      = var.project_id
  ha_vpn_gateways = var.ha_vpn_gateways
  depends_on      = [module.cloud_interconnect_attachment] # Ensuring VLAN are created first
}


###########################
#  External VPN Gateways  #
###########################
module "external_vpn_gateways" {
  source                = "../../../../modules/networking/cloud-vpn/external-vpn-gateway"
  project_id            = var.project_id
  external_vpn_gateways = var.external_vpn_gateways
}

#################
#  VPN Tunnels  #
#################
module "vpn_tunnels" {
  source      = "../../../../modules/networking/cloud-vpn/vpn-tunnels"
  project_id  = var.project_id
  vpn_tunnels = var.vpn_tunnels
  depends_on  = [module.cloud_interconnect_attachment, module.ha_vpn_gateways, module.external_vpn_gateways]
}

