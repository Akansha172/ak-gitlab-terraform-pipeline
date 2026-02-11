terraform {
  backend "gcs" {
    bucket = "org-bucket-prod-tfstate"
    prefix = "ou/gcp-project"
  }
}
