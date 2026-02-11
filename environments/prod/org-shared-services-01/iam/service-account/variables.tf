####################################
#  Service Account and IAM Roles   #
####################################
variable "service_accounts" {
  description = "List of service accounts to be created, including IAM role bindings at org, folder, and project levels"
  type = list(object({

    project_id                   = string                 # (Required) Project ID where the service account will be created
    account_id                   = string                 # (Required) Unique service account ID (RFC1035 compliant), 6-30 characters, lowercase letters, digits or hyphens. Changing this forces recreation.
    display_name                 = optional(string, null) # (Optional) Display name for the service account. Can be updated without recreating the account.
    description                  = optional(string, null) # (Optional) Description for the service account. Must be ≤ 256 UTF-8 bytes.
    disabled                     = optional(bool, false)  # (Optional) Whether to disable the service account. Default is false. Can only be applied after creation.
    create_ignore_already_exists = optional(bool, true)   # (Optional) Skip creation if a service account with the same email already exists.

    org_roles = optional(list(object({ # (Optional) IAM roles to bind at the organization level.
      org_id = string                  # Organization ID (e.g. "123456789012")
      roles  = list(string)            # List of roles to assign at the org level
    })), null)

    folder_roles = optional(list(object({ # (Optional) IAM roles to bind at the folder level.
      folder = string                     # Folder ID (e.g. "folders/123456789012")
      roles  = list(string)               # List of roles to assign at the folder level
    })), null)

    project_roles = optional(list(object({ # (Optional) IAM roles to bind at the project level.
      project = string                     # Project ID where the role should be applied
      roles   = list(string)               # List of roles to assign at the project level
    })), null)

    service_account_members = optional(list(object({ # (Optional) IAM bindings for external identities (e.g. GitLab WIF).
      role   = string                                # IAM role to assign (e.g., "roles/iam.workloadIdentityUser")
      member = string                                # Member identifier (e.g., principalSet://... for WIF pools)
    })), null)
  }))
}
