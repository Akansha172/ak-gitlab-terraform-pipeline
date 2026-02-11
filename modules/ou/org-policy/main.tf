###################
#  Org Policies   #
###################
resource "google_org_policy_policy" "org_policy" {
  for_each = var.org_policies

  name   = each.value.name
  parent = each.value.parent

  dynamic "spec" {
    for_each = each.value.spec != null ? [each.value.spec] : []
    content {
      inherit_from_parent = spec.value.reset ? false : spec.value.inherit_from_parent # If reset is true, then set inherit_from_parent = false
      reset               = spec.value.reset

      dynamic "rules" {
        for_each = spec.value.reset ? [] : (spec.value.rules != null ? spec.value.rules : []) # If reset is true, then rules will be empty
        content {
          enforce    = rules.value.enforce
          allow_all  = rules.value.allow_all
          deny_all   = rules.value.deny_all
          parameters = rules.value.parameters

          dynamic "values" {
            for_each = rules.value.values != null ? [rules.value.values] : []
            content {
              allowed_values = values.value.allowed_values
              denied_values  = values.value.denied_values
            }
          }

          dynamic "condition" {
            for_each = rules.value.condition != null ? [rules.value.condition] : []
            content {
              expression  = condition.value.expression
              title       = condition.value.title
              description = condition.value.description
              location    = condition.value.location
            }
          }
        }
      }
    }
  }

  dynamic "dry_run_spec" {
    for_each = each.value.dry_run_spec != null ? [each.value.dry_run_spec] : []
    content {
      inherit_from_parent = dry_run_spec.value.reset ? false : dry_run_spec.value.inherit_from_parent # If reset is true, then set inherit_from_parent = false
      reset               = dry_run_spec.value.reset

      dynamic "rules" {
        for_each = dry_run_spec.value.reset ? [] : (dry_run_spec.value.rules != null ? dry_run_spec.value.rules : []) # If reset is true, then rules will be empty
        content {
          enforce    = rules.value.enforce
          allow_all  = rules.value.allow_all
          deny_all   = rules.value.deny_all
          parameters = rules.value.parameters

          dynamic "values" {
            for_each = rules.value.values != null ? [rules.value.values] : []
            content {
              allowed_values = values.value.allowed_values
              denied_values  = values.value.denied_values
            }
          }

          dynamic "condition" {
            for_each = rules.value.condition != null ? [rules.value.condition] : []
            content {
              expression  = condition.value.expression
              title       = condition.value.title
              description = condition.value.description
              location    = condition.value.location
            }
          }
        }
      }
    }
  }
}
