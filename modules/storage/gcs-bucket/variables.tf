##################
#  GCS Buckets   #
##################
variable "buckets" {
  description = "A map of storage buckets to create."
  type = map(object({
    name                       = string                       # The name of the bucket.
    project_id                 = string                       # The ID of the project to create the bucket in.
    location                   = string                       # The location of the bucket.
    storage_class              = optional(string, "STANDARD") # The Storage Class of the new bucket.
    labels                     = optional(map(string), null)  # A set of key/value label pairs to assign to the bucket.
    bucket_policy_only         = optional(bool, true)         # Enables Bucket Policy Only access to a bucket.
    retention_duration_seconds = optional(number, 604800)     # The bucket's soft delete policy, defining the retention period of soft-deleted objects.
    versioning                 = optional(bool, true)         # Enables versioning for this bucket.
    autoclass                  = optional(bool, false)        # Enables autoclass for this bucket.
    force_destroy              = optional(bool, false)        # If true, allows deletion of non-empty buckets.
    public_access_prevention   = optional(string, "enforced") # Prevents public access to a bucket. Acceptable values: inherited or enforced.
    lifecycle_rules = optional(list(object({
      action = object({
        type          = string           # Type of lifecycle action (Delete or SetStorageClass).
        storage_class = optional(string) # Target storage class for SetStorageClass action.
      })

      condition = object({
        age                        = optional(number)       # Minimum object age in days.
        created_before             = optional(string)       # Object creation date in RFC 3339 format.
        is_live                    = optional(bool)         # Whether the object is live.
        num_newer_versions         = optional(number)       # Number of newer versions required to match.
        custom_time_before         = optional(string)       # Object custom time threshold.
        days_since_custom_time     = optional(number)       # Days since custom time for object.
        days_since_noncurrent_time = optional(number)       # Days since object became noncurrent.
        noncurrent_time_before     = optional(string)       # Noncurrent time threshold for object.
        with_state                 = optional(string)       # Match to live and/or archived objects (LIVE, ARCHIVED, ANY).
        matches_storage_class      = optional(list(string)) # List of storage classes to satisfy this condition.
        matches_prefix             = optional(list(string)) # List of matching name prefixes.
        matches_suffix             = optional(list(string)) # List of matching name suffixes.
      })
    })), [])
  }))
}
