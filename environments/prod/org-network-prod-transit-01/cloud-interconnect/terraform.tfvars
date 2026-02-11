################
#  Project ID  #
################
project_id = "org-network-prod-transit-01"

###################
#  Cloud Routers  #
###################
routers = {
  "cr-org-prod-gcp-to-onprem-uw1-01" = { # Used for Interconnect
    network                       = "org-vpc-prod-transit"
    region                        = "us-west1"
    encrypted_interconnect_router = true
    bgp = {
      keepalive_interval = 60
      asn                = 16550
    }
  },
  "cr-org-prod-on-prem-to-gcp-uw1-02" = { # Used for HA VPN
    network = "org-vpc-prod-transit"
    region  = "us-west1"
    bgp = {
      keepalive_interval = 60
      asn                = 16550
    }
  }
}


####################################
#  Interconnect Attachment (VLAN)  #
####################################
interconnect_attachments = {
  "org-vlan-prod-gcp-to-onprem-uw1-01" = {
    description              = "<DESCRIPTION>"
    edge_availability_domain = "AVAILABILITY_DOMAIN_1"
    type                     = "PARTNER"
    region                   = "us-west1"
    router_name              = "cr-org-prod-gcp-to-onprem-uw1-01"
    encryption               = "IPSEC"
    ip_configs = [
      {
        name          = "org-ip-prod-vlan-gcp-to-onprem-uw1-a"
        address       = "<IP_ADDRESS>"
        prefix_length = "29"
        address_type  = "INTERNAL"
        purpose       = "IPSEC_INTERCONNECT"
        region        = "us-west1"
        network       = "https://www.googleapis.com/compute/v1/projects/org-network-prod-transit-01/global/networks/org-vpc-prod-transit"
      }
    ]
  },
  "org-vlan-prod-gcp-to-onprem-uw1-02" = {
    description              = "<DESCRIPTION>"
    edge_availability_domain = "AVAILABILITY_DOMAIN_2"
    type                     = "PARTNER"
    region                   = "us-west1"
    router_name              = "cr-org-prod-gcp-to-onprem-uw1-01"
    encryption               = "IPSEC"
    ip_configs = [
      {
        name          = "org-ip-prod-vlan-gcp-to-onprem-uw1-b"
        address       = "<IP_ADDRESS>"
        prefix_length = "29"
        address_type  = "INTERNAL"
        purpose       = "IPSEC_INTERCONNECT"
        region        = "us-west1"
        network       = "https://www.googleapis.com/compute/v1/projects/org-network-prod-transit-01/global/networks/org-vpc-prod-transit"
      }
    ]
  }
}


######################
# Router Interfaces  #
######################
router_interfaces = {
  "auto-ia-if-org-vlan-prod-gc-18f0b606fa57f10" = {
    router                  = "cr-org-prod-gcp-to-onprem-uw1-01"
    region                  = "us-west1"
    ip_range                = "<IP_ADDRESS>/29"
    interconnect_attachment = "https://www.googleapis.com/compute/v1/projects/org-network-prod-transit-01/regions/us-west1/interconnectAttachments/org-vlan-prod-gcp-to-onprem-uw1-01"
  },
  "auto-ia-if-org-vlan-prod-gc-7b7b45d228b153b" = {
    router                  = "cr-org-prod-gcp-to-onprem-uw1-01"
    region                  = "us-west1"
    ip_range                = "<IP_ADDRESS>/29"
    interconnect_attachment = "https://www.googleapis.com/compute/v1/projects/org-network-prod-transit-01/regions/us-west1/interconnectAttachments/org-vlan-prod-gcp-to-onprem-uw1-02"
  },
  "if-org-bgp-prod-on-prem-to-gcp-uw1-01" = {
    router     = "cr-org-prod-on-prem-to-gcp-uw1-02"
    region     = "us-west1"
    ip_range   = "<IP_ADDRESS>/30"
    vpn_tunnel = "https://www.googleapis.com/compute/v1/projects/org-network-prod-transit-01/regions/us-west1/vpnTunnels/org-tunnel-prod-on-prem-to-gcp-uw1-01"
  },
  "if-org-bgp-prod-on-prem-to-gcp-uw1-02" = {
    router     = "cr-org-prod-on-prem-to-gcp-uw1-02"
    region     = "us-west1"
    ip_range   = "<IP_ADDRESS>/30"
    vpn_tunnel = "https://www.googleapis.com/compute/v1/projects/org-network-prod-transit-01/regions/us-west1/vpnTunnels/org-tunnel-prod-on-prem-to-gcp-uw1-02"
  },
  "if-org-bgp-prod-on-prem-to-gcp-uw1-03" = {
    router     = "cr-org-prod-on-prem-to-gcp-uw1-02"
    region     = "us-west1"
    ip_range   = "<IP_ADDRESS>/30"
    vpn_tunnel = "https://www.googleapis.com/compute/v1/projects/org-network-prod-transit-01/regions/us-west1/vpnTunnels/org-tunnel-prod-on-prem-to-gcp-uw1-03"
  },
  "if-org-bgp-prod-on-prem-to-gcp-uw1-04" = {
    router     = "cr-org-prod-on-prem-to-gcp-uw1-02"
    region     = "us-west1"
    ip_range   = "<IP_ADDRESS>/30"
    vpn_tunnel = "https://www.googleapis.com/compute/v1/projects/org-network-prod-transit-01/regions/us-west1/vpnTunnels/org-tunnel-prod-on-prem-to-gcp-uw1-04"
  }
}

################
# Router Peers #
################
router_peers = {
  "auto-ia-bgp-org-vlan-prod-gc-7b7b45d228b153b" = {
    interface                 = "auto-ia-if-org-vlan-prod-gc-7b7b45d228b153b"
    peer_asn                  = 65409
    router                    = "cr-org-prod-gcp-to-onprem-uw1-01"
    ip_address                = "<IP_ADDRESS>"
    peer_ip_address           = "<IP_ADDRESS>"
    advertised_route_priority = 0
    md5_authentication_key = {
      name = "auto-ia-bgp-org-vlan-prod-gc-7b7b45d228b153b-key"
      key  = "" # Has been already filled through GCP Console, kept empty here, to update, add logic to fill in secret value here    
    }
  },
  "auto-ia-bgp-org-vlan-prod-gc-18f0b606fa57f10" = {
    interface                 = "auto-ia-if-org-vlan-prod-gc-18f0b606fa57f10"
    peer_asn                  = 65409
    router                    = "cr-org-prod-gcp-to-onprem-uw1-01"
    ip_address                = "<IP_ADDRESS>"
    peer_ip_address           = "<IP_ADDRESS>"
    advertised_route_priority = 0
    md5_authentication_key = {
      name = "auto-ia-bgp-org-vlan-prod-gc-18f0b606fa57f10-key"
      key  = "" # Has been already filled through GCP Console, kept empty here, to update, add logic to fill in secret value here    
    }
  },
  "org-bgp-prod-on-prem-to-gcp-uw1-01" = {
    interface                 = "if-org-bgp-prod-on-prem-to-gcp-uw1-01"
    router                    = "cr-org-prod-on-prem-to-gcp-uw1-02"
    peer_asn                  = 65409
    ip_address                = "<IP_ADDRESS>"
    peer_ip_address           = "<IP_ADDRESS>"
    advertised_route_priority = 0
    md5_authentication_key = {
      name = "org-bgp-prod-on-prem-to-gcp-uw1-01-key"
      key  = "" # Has been already filled through GCP Console, kept empty here, to update, add logic to fill in secret value here    
    }
  },
  "org-bgp-prod-on-prem-to-gcp-uw1-02" = {
    interface                 = "if-org-bgp-prod-on-prem-to-gcp-uw1-02"
    router                    = "cr-org-prod-on-prem-to-gcp-uw1-02"
    peer_asn                  = 65409
    ip_address                = "<IP_ADDRESS>"
    peer_ip_address           = "<IP_ADDRESS>"
    advertised_route_priority = 0
    md5_authentication_key = {
      name = "org-bgp-prod-on-prem-to-gcp-uw1-02-key"
      key  = "" # Has been already filled through GCP Console, kept empty here, to update, add logic to fill in secret value here    
    }
  },
  "org-bgp-prod-on-prem-to-gcp-uw1-03" = {
    interface                 = "if-org-bgp-prod-on-prem-to-gcp-uw1-03"
    router                    = "cr-org-prod-on-prem-to-gcp-uw1-02"
    peer_asn                  = 65409
    ip_address                = "<IP_ADDRESS>"
    peer_ip_address           = "<IP_ADDRESS>"
    advertised_route_priority = 0
    md5_authentication_key = {
      name = "org-bgp-prod-on-prem-to-gcp-uw1-03-key"
      key  = "" # Has been already filled through GCP Console, kept empty here, to update, add logic to fill in secret value here    
    }
  },
  "org-bgp-prod-on-prem-to-gcp-uw1-04" = {
    interface                 = "if-org-bgp-prod-on-prem-to-gcp-uw1-04"
    router                    = "cr-org-prod-on-prem-to-gcp-uw1-02"
    peer_asn                  = 65409
    ip_address                = "<IP_ADDRESS>"
    peer_ip_address           = "<IP_ADDRESS>"
    advertised_route_priority = 0
    md5_authentication_key = {
      name = "org-bgp-prod-on-prem-to-gcp-uw1-04-key"
      key  = "" # Has been already filled through GCP Console, kept empty here, to update, add logic to fill in secret value here    
    }
  }
}

####################
#  HA VPN Gateways #
####################
ha_vpn_gateways = {
  "org-ha-vpn-gw-prod-gcp-to-on-prem-uw1-01" = {
    network = "https://www.googleapis.com/compute/v1/projects/org-network-prod-transit-01/global/networks/org-vpc-prod-transit"
    region  = "us-west1"
    vpn_interfaces = [
      {
        id                      = 0
        interconnect_attachment = "https://www.googleapis.com/compute/v1/projects/org-network-prod-transit-01/regions/us-west1/interconnectAttachments/org-vlan-prod-gcp-to-onprem-uw1-01"
      },
      {
        id                      = 1
        interconnect_attachment = "https://www.googleapis.com/compute/v1/projects/org-network-prod-transit-01/regions/us-west1/interconnectAttachments/org-vlan-prod-gcp-to-onprem-uw1-02"
      }
    ]
  },
  "org-ha-vpn-gw-prod-gcp-to-on-prem-uw1-02" = {
    network = "https://www.googleapis.com/compute/v1/projects/org-network-prod-transit-01/global/networks/org-vpc-prod-transit"
    region  = "us-west1"
    vpn_interfaces = [
      {
        id                      = 0
        interconnect_attachment = "https://www.googleapis.com/compute/v1/projects/org-network-prod-transit-01/regions/us-west1/interconnectAttachments/org-vlan-prod-gcp-to-onprem-uw1-01"
      },
      {
        id                      = 1
        interconnect_attachment = "https://www.googleapis.com/compute/v1/projects/org-network-prod-transit-01/regions/us-west1/interconnectAttachments/org-vlan-prod-gcp-to-onprem-uw1-02"
      }
    ]
  }
}

###########################
#  External VPN Gateways  #
###########################
external_vpn_gateways = {
  "org-ha-peer-vpn-gw-prod-on-prem-to-gcp-uw1-01" = { # Peer VPN (Onprem)
    redundancy_type = "TWO_IPS_REDUNDANCY"
    interfaces = [
      {
        id         = 0
        ip_address = "<IP_ADDRESS>"
      },
      {
        id         = 1
        ip_address = "<IP_ADDRESS>"
      }
    ]
  },
  "org-ha-peer-vpn-gw-prod-on-prem-to-gcp-uw1-02" = { # Peer VPN (Onprem)
    redundancy_type = "TWO_IPS_REDUNDANCY"
    interfaces = [
      {
        id         = 0
        ip_address = "<IP_ADDRESS>"
      },
      {
        id         = 1
        ip_address = "<IP_ADDRESS>"
      }
    ]
  }
}


#################
#  VPN Tunnels  #
#################
vpn_tunnels = {
  org-tunnel-prod-on-prem-to-gcp-uw1-01 = {
    name                            = "org-tunnel-prod-on-prem-to-gcp-uw1-01"
    shared_secret                   = ""
    vpn_gateway                     = "https://www.googleapis.com/compute/v1/projects/org-network-prod-transit-01/regions/us-west1/vpnGateways/org-ha-vpn-gw-prod-gcp-to-on-prem-uw1-01"
    vpn_gateway_interface           = 0
    peer_external_gateway           = "https://www.googleapis.com/compute/v1/projects/org-network-prod-transit-01/global/externalVpnGateways/org-ha-peer-vpn-gw-prod-on-prem-to-gcp-uw1-01"
    peer_external_gateway_interface = 0
    router                          = "https://www.googleapis.com/compute/v1/projects/org-network-prod-transit-01/regions/us-west1/routers/cr-org-prod-on-prem-to-gcp-uw1-02"
    ike_version                     = 2
    local_traffic_selector          = ["0.0.0.0/0"]
    remote_traffic_selector         = ["0.0.0.0/0"]
    region                          = "us-west1"
  },
  org-tunnel-prod-on-prem-to-gcp-uw1-02 = {
    name                            = "org-tunnel-prod-on-prem-to-gcp-uw1-02"
    shared_secret                   = ""
    vpn_gateway                     = "https://www.googleapis.com/compute/v1/projects/org-network-prod-transit-01/regions/us-west1/vpnGateways/org-ha-vpn-gw-prod-gcp-to-on-prem-uw1-01"
    vpn_gateway_interface           = 1
    peer_external_gateway           = "https://www.googleapis.com/compute/v1/projects/org-network-prod-transit-01/global/externalVpnGateways/org-ha-peer-vpn-gw-prod-on-prem-to-gcp-uw1-01"
    peer_external_gateway_interface = 1
    router                          = "https://www.googleapis.com/compute/v1/projects/org-network-prod-transit-01/regions/us-west1/routers/cr-org-prod-on-prem-to-gcp-uw1-02"
    ike_version                     = 2
    local_traffic_selector          = ["0.0.0.0/0"]
    remote_traffic_selector         = ["0.0.0.0/0"]
    region                          = "us-west1"
  },
  org-tunnel-prod-on-prem-to-gcp-uw1-03 = {
    name                            = "org-tunnel-prod-on-prem-to-gcp-uw1-03"
    shared_secret                   = ""
    vpn_gateway                     = "https://www.googleapis.com/compute/v1/projects/org-network-prod-transit-01/regions/us-west1/vpnGateways/org-ha-vpn-gw-prod-gcp-to-on-prem-uw1-02"
    vpn_gateway_interface           = 0
    peer_external_gateway           = "https://www.googleapis.com/compute/v1/projects/org-network-prod-transit-01/global/externalVpnGateways/org-ha-peer-vpn-gw-prod-on-prem-to-gcp-uw1-02"
    peer_external_gateway_interface = 0
    router                          = "https://www.googleapis.com/compute/v1/projects/org-network-prod-transit-01/regions/us-west1/routers/cr-org-prod-on-prem-to-gcp-uw1-02"
    ike_version                     = 2
    local_traffic_selector          = ["0.0.0.0/0"]
    remote_traffic_selector         = ["0.0.0.0/0"]
    region                          = "us-west1"
  },
  org-tunnel-prod-on-prem-to-gcp-uw1-04 = {
    name                            = "org-tunnel-prod-on-prem-to-gcp-uw1-04"
    shared_secret                   = ""
    vpn_gateway                     = "https://www.googleapis.com/compute/v1/projects/org-network-prod-transit-01/regions/us-west1/vpnGateways/org-ha-vpn-gw-prod-gcp-to-on-prem-uw1-02"
    vpn_gateway_interface           = 1
    peer_external_gateway           = "https://www.googleapis.com/compute/v1/projects/org-network-prod-transit-01/global/externalVpnGateways/org-ha-peer-vpn-gw-prod-on-prem-to-gcp-uw1-02"
    peer_external_gateway_interface = 1
    router                          = "https://www.googleapis.com/compute/v1/projects/org-network-prod-transit-01/regions/us-west1/routers/cr-org-prod-on-prem-to-gcp-uw1-02"
    ike_version                     = 2
    local_traffic_selector          = ["0.0.0.0/0"]
    remote_traffic_selector         = ["0.0.0.0/0"]
    region                          = "us-west1"
  }
}