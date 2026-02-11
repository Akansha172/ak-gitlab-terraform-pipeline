/*
This module can be used to manage GCP Organization Policies.

The following policies are enabled by default (enforce = "TRUE") when managed via Terraform:

  iam.allowServiceAccountCredentialLifetimeExtension
  resourcemanager.allowedExportDestinations
  resourcemanager.allowedImportSources
  cloudbuild.disableCreateDefaultServiceAccount
  resourcemanager.allowEnabledServicesForExport
  commerceorggovernance.marketplaceServices
  appengine.runtimeDeploymentExemption
  iam.serviceAccountKeyExposureResponse
  compute.sharedReservationsOwnerProjects
  cloudbuild.useComputeServiceAccount
  cloudbuild.useBuildServiceAccount

When a policy is created via Terraform and later destroyed, its state reverts:
  If it was inactive before, it becomes inactive again.
  If it was already active before Terraform created it, it stays active after destruction.

To modify or add more policies, use the org_policies variable.
For folder or project-level policies, update the name field accordingly. Refer to variables.tf for more details.


Example for LIST type of policy - 
example_policy = {
    name   = "organizations/<org-id>/policies/constraint_name"
    parent = "organizations/<org-id>"
    spec = {
      rules = [
        {
        condition = {
          description = "A sample condition for the policy"
          expression  = "resource.matchTagId('tagKeys/123', 'tagValues/345')"
          location    = "sample-location.log"
          title       = "sample-condition"
        }
        values = {
          allowed_values = ["projects/allowed-project"]
          denied_values  = ["projects/denied-project"]
        }
        },
        {
          allow_all = "TRUE"
        }
      ]
    }
  }

*/

###################
#  Org Policies   #
###################
org_policies = {
  disable_sa_key_creation = {
    name   = "organizations/<org-id>/policies/iam.disableServiceAccountKeyCreation"
    parent = "organizations/<org-id>"
    spec = {
      rules = [
        {
          enforce = "TRUE"
        }
      ]
    }
  },
  disable_sa_key_upload = {
    name   = "organizations/<org-id>/policies/iam.disableServiceAccountKeyUpload"
    parent = "organizations/<org-id>"
    spec = {
      rules = [
        {
          enforce = "TRUE"
        }
      ]
    }
  },
  # Can manage already existing policies as well-
  cloudbuild_disable_create_default_sa = {
    name   = "organizations/<org-id>/policies/cloudbuild.disableCreateDefaultServiceAccount"
    parent = "organizations/<org-id>"
    spec = {
      rules = [
        {
          enforce = "TRUE"
        }
      ]
    }
  }
}
