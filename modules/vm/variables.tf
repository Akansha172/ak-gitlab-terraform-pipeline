################
#  Project ID  #
################
variable "project_id" {
  description = "The ID of the project where this GKE Cluster will be created"
  type        = string
  default     = null
}

######################
#  Location Details  #
######################
variable "zone" {
  description = "Name of the zone"
  type        = string
  default     = null
}

variable "region" {
  description = "The region of the IP reserved"
  type        = string
  default     = null
}

################
#  VM Details  #
################
variable "name" {
  description = "Name of the instance"
  type        = string
  default     = null
}

variable "image" {
  description = "Boot disk image"
  type        = string
  default     = null
}

variable "machine_type" {
  description = "Name of the machine"
  type        = string
  default     = null
}

variable "size" {
  description = "Size of the boot disk"
  type        = string
  default     = null
}

variable "can_ip_forward" {
  description = "Enable IP forwarding"
  type        = bool
  default     = null
}

variable "deletion_protection" {
  description = "VM instance can be protected from accidental deletion"
  type        = bool
  default     = null
}

variable "labels" {
  description = "Labels, provided as a map"
  type        = map(string)
  default     = null
}

variable "network" {
  description = "Name of the network"
  type        = string
  default     = null
}

variable "subnetwork_project" {
  description = "Name of the project"
  type        = string
  default     = null
}

variable "subnetwork" {
  description = "Name of the subnetwork"
  type        = string
  default     = null
}

variable "network_tier" {
  description = "Name of the network tire"
  type        = string
  default     = null
}

variable "stack_type" {
  description = "Type of stack IPV4 or IPV6"
  type        = string
  default     = null
}

variable "on_host_maintenance" {
  description = "maintenance of VM"
  type        = string
  default     = null
}

variable "preemptible" {
  description = "Preemptible VM's"
  type        = bool
  default     = false
}

variable "email" {
  description = "service account email"
  type        = string
  default     = null
}

variable "scopes" {
  description = "List of API's for accessing"
  type        = list(string)
  default     = null
}

variable "tags" {
  description = "List of tags"
  type        = list(string)
  default     = null
}

variable "private_ip_name" {
  description = "The name of the private static ip."
  type        = string
  default     = null
}

variable "address_type" {
  description = "The address type, can be EXTERNAL/INTERNAL."
  type        = string
  default     = null
}

variable "purpose" {
  description = "The purpose of the static IP. GCE_ENDPOINT"
  type        = string
  default     = null
}

variable "private_address" {
  description = "The reserved private static ip address"
  type        = string
  default     = null
}

variable "create_static_private_ip" {
  description = "Whether to create static IP or not"
  type        = bool
  default     = false
}

variable "key_revocation_action_type" {
  type    = string
  default = null
}

variable "auto_delete_disk" {
  type    = bool
  default = true
}

variable "create_static_public_ip" {
  type    = bool
  default = false
}

variable "public_ip_name" {
  type    = string
  default = null
}

variable "address_type_public" {
  type    = string
  default = null
}

variable "public_ip_address_description" {
  type    = string
  default = null
}

variable "public_ip_ptr_domain_name" {
  type    = string
  default = null
}

variable "metadata" {
  description = "A map for metadata values."
  type        = map(string)
  default     = null
}
