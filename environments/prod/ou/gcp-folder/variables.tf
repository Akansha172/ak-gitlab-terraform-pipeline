##################
#  GCP Folders   #
##################
variable "folders" {
  type = list(object({
    name   = string                    # Name of the folder to create.
    parent = string                    # Resource ID of the parent (either org or folder).
    tags   = optional(map(string), {}) # Optional key-value tags to apply to the folder.
  }))
}
