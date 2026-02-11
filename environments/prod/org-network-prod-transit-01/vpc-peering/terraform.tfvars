/* To be uncommented when we will create VPC-peering
##################
#  VPC peerings  # 
##################
peerings = {
  org-peerings-prod-transit-to-prod = {
    name         = "org-peerings-prod-transit-to-prod"
    network      = "projects/org-network-prod-transit-01/global/networks/org-vpc-prod-transit"
    peer_network = "projects/org-network-prod-01/global/networks/org-vpc-prod"
    export_custom_routes = true
  }
  org-peerings-prod-to-prod-transit = {
    name         = "org-peerings-prod-to-prod-transit"
    network      = "projects/org-network-prod-01/global/networks/org-vpc-prod"
    peer_network = "projects/org-network-prod-transit-01/global/networks/org-vpc-prod-transit"
    import_custom_routes = true
  }

  org-peerings-prod-transit-to-dev = {
    name         = "org-peerings-prod-transit-to-dev"
    network      = "projects/org-network-prod-transit-01/global/networks/org-vpc-prod-transit"
    peer_network = "projects/org-network-dev-01/global/networks/org-vpc-dev"
    export_custom_routes = true
  }
  org-peerings-dev-to-prod-transit = {
    name         = "org-peerings-dev-to-prod-transit"
    network      = "projects/org-network-dev-01/global/networks/org-vpc-dev"
    peer_network = "projects/org-network-prod-transit-01/global/networks/org-vpc-prod-transit"
    import_custom_routes = true
  }
}
*/
