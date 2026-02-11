###################
#  Org Policies   #
###################
variable "org_policies" {
  description = "A map of organization policies to create."
  type = map(object({

    name = string # (Required) Full policy name. Format: organizations/{id}/policies/{constraint}
    # Acceptable: projects/{project_number}/policies/{constraint_name}, folders/{folder_id}/policies/{constraint_name}, organizations/{organization_id}/policies/{constraint_name}

    parent = string # (Required) Parent resource. Format: organizations/{id}, folders/{id}, or projects/{id}

    spec = optional(object({                      # (Optional) Actual policy configuration
      inherit_from_parent = optional(bool, false) # (Optional) If true, inherit rules from parent. Default: false. Used only in list constraints
      reset               = optional(bool, false) # (Optional) If true, resets policy to constraint_default. Default: false.
      # When true: rules must be empty AND inherit_from_parent must be false

      # Note: If reset is true, this must be omitted or empty, still if given, resource will keep it empty
      rules = optional(list(object({ # (Optional) List of rules to enforce

        enforce = optional(string) # (Optional) For boolean constraints only. TRUE = enforced, FALSE = any config allowed. Default: not set

        values = optional(object({
          allowed_values = optional(list(string)) # (Optional) For list constraints only. Values explicitly allowed. Default: not set
          denied_values  = optional(list(string)) # (Optional) For list constraints only. Values explicitly denied. Default: not set
        }))

        allow_all  = optional(string) # (Optional) For list constraints only. If TRUE, all values allowed. Default: not set
        deny_all   = optional(string) # (Optional) For list constraints only. If TRUE, all values denied. Default: not set
        parameters = optional(string) # (Optional) Required for some Managed Constraints if they define parameters. Default: not set. Example: { "allowedLocations": ["us-east1"], "allowAll": true }

        condition = optional(object({    # (Optional) Expression to determine if rule is applied
          expression  = optional(string) # (Optional) CEL expression. Example: "resource.matchTag('env', 'prod')". Default: not set
          title       = optional(string) # (Optional) Title for the expression. Default: not set
          description = optional(string) # (Optional) Description for the expression. Default: not set
          location    = optional(string) # (Optional) Location for debugging. Default: not set
        }))

      })))
    }))

    dry_run_spec = optional(object({              # (Optional) Dry-run config to simulate policy effect
      inherit_from_parent = optional(bool, false) # (Optional) Same behavior as spec.inherit_from_parent. Default: false
      reset               = optional(bool, false) # (Optional) Same behavior as spec.reset. Default: false
      # When true: rules must be empty AND inherit_from_parent must be false

      # Note: If reset is true, this must be omitted or empty, still if given, resource will keep it empty
      rules = optional(list(object({
        enforce = optional(string) # (Optional) For boolean constraints. Default: not set

        values = optional(object({
          allowed_values = optional(list(string)) # (Optional) Allowed values for list constraints. Default: not set
          denied_values  = optional(list(string)) # (Optional) Denied values for list constraints. Default: not set
        }))

        allow_all  = optional(string) # (Optional) Allow all values (list constraints only). Default: not set
        deny_all   = optional(string) # (Optional) Deny all values (list constraints only). Default: not set
        parameters = optional(string) # (Optional) Same as in spec.rules.parameters. Default: not set

        condition = optional(object({
          expression  = optional(string) # (Optional) CEL condition expression. Default: not set
          title       = optional(string) # (Optional) Title for condition. Default: not set
          description = optional(string) # (Optional) Description of the condition. Default: not set
          location    = optional(string) # (Optional) Debug location. Default: not set
        }))

      })))
    }))

  }))
}
