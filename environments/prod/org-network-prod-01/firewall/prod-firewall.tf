##################
/* Firewall Rules */
####################

module "firewall_rules" {
  source = "../../../../modules/networking/firewall"

  project_id   = var.project_id
  network_name = var.network_name
  rules        = var.rules
}
