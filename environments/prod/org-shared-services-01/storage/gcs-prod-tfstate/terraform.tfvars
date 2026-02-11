##################
#  GCS Buckets   #
##################
buckets = {
  "org-bucket-prod-tfstate" = {
    name       = "org-bucket-prod-tfstate"
    project_id = "org-shared-services-01"
    location   = "us-west1"
    lifecycle_rules = [
      { # Delete noncurrent objects with 2 or more newer versions
        action = {
          type = "Delete"
        }
        condition = {
          num_newer_versions = 2
          with_state         = "ARCHIVED" # Ensures the object is noncurrent
          is_live            = false
        }
      },
      { # Delete noncurrent objects after 7 days
        action = {
          type = "Delete"
        }
        condition = {
          days_since_noncurrent_time = 7
          with_state                 = "ARCHIVED" # Ensures the object is noncurrent
          is_live                    = false
        }
      }
    ]
  }
}
