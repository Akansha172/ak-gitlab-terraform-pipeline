################
#  Project ID  #
################
variable "project_id" {
  description = "GCP Project ID"
  type        = string # (Required) The ID of the GCP project where the Workload Identity Pools and Providers will be created.
}

##################################
#  Workload Identity Providers   #
##################################
variable "identity_providers" {
  description = "Map of Workload Identity Providers with their pool reference"
  type = map(object({
    pool_name           = string                     # (Required) Name of the pool this provider belongs to
    url                 = string                     # (Required) OIDC issuer URL or SAML metadata URL
    attribute_mapping   = optional(map(string), {})  # (Optional) Mapping of OIDC/SAML attributes to GCP attributes
    attribute_condition = optional(string, null)     # (Optional) Condition to restrict identities based on attributes
    allowed_audiences   = optional(list(string), []) # (Optional) List of allowed audience values for the identity token
  }))
  default = {}
  # Map of identity provider configurations, where the key is a provider name.
  # Each entry includes metadata about the provider and its configuration within a pool.
}