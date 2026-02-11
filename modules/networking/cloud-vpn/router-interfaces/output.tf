output "router_interfaces" {
  description = "Self links of created router interfaces"
  value = {
    for k, v in google_compute_router_interface.router_interfaces :
    k => v.id
  }
}
