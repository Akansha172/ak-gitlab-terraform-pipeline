#####################
#  Virtual Machine  #
#####################
/* Uncomment this block and edit the values as per need to create the resource
region     = "us-east4"
project_id = "org-network-prod-01"

zone                = "us-east4-a"
labels              = { env = "prod", team = "devops", deployed-by = "org" }
image               = "ubuntu-2204-jammy-v20240701"
can_ip_forward      = false
deletion_protection = false
machine_type        = "e2-medium"
name                = "org-vm-prod-bastion-ue4"
network             = "https://www.googleapis.com/compute/v1/projects/org-network-prod-01/global/networks/org-vpc-prod"
subnetwork_project  = "org-network-prod-01"
stack_type          = "IPV4_ONLY"
subnetwork          = "https://www.googleapis.com/compute/v1/projects/org-network-prod-01/regions/asia-south1/subnetworks/org-subnet-prod-app-ue4"
on_host_maintenance = "MIGRATE" // if preemptible is true then the value should to be  "TERMINATE"
preemptible         = "false"
email               = "<compute-sa-number>-compute@developer.gserviceaccount.com"
scopes              = ["cloud-platform"] #All API's Access Provided
tags                = ["prod"]
size                = "50"
metadata            = { "enable-osconfig" = "TRUE" } //required for OPS agent

# Static Private IP
create_static_private_ip = false
private_ip_name          = "org-vm-prod-bastion-static-private-ip"
address_type             = "INTERNAL"
purpose                  = "GCE_ENDPOINT"
private_address          = "<PRIVATE_IP_ADDRESS>"

# Static Public IP
create_static_public_ip  = false
public_ip_name           = "org-vm-prod-bastion-static-public-ip"
public_ip_address_description = "Static public IP for VM"
address_type_public      = "EXTERNAL"
public_ip_ptr_domain_name = "vm.example.com"
*/