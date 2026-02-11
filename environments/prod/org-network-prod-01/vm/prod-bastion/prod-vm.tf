#####################
#  Virtual Machine  #
#####################
module "vm" {
  source              = "../../../../../modules/vm"
  zone                = var.zone
  labels              = var.labels
  image               = var.image
  project_id          = var.project_id
  can_ip_forward      = var.can_ip_forward
  deletion_protection = var.deletion_protection
  machine_type        = var.machine_type
  name                = var.name
  network             = var.network
  subnetwork_project  = var.subnetwork_project
  stack_type          = var.stack_type
  subnetwork          = var.subnetwork
  on_host_maintenance = var.on_host_maintenance
  preemptible         = var.preemptible
  email               = var.email
  scopes              = var.scopes
  tags                = var.tags
  size                = var.size
  metadata            = var.metadata

  create_static_private_ip = var.create_static_private_ip
  private_ip_name          = var.private_ip_name
  address_type             = var.address_type
  purpose                  = var.purpose
  private_address          = var.private_address

  create_static_public_ip       = var.create_static_public_ip
  public_ip_name                = var.public_ip_name
  public_ip_address_description = var.public_ip_address_description
  address_type_public           = var.address_type_public
  public_ip_ptr_domain_name     = var.public_ip_ptr_domain_name
}