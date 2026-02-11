terraform {
  backend "gcs" {
    bucket = "org-bucket-prod-tfstate"
    prefix = "org-network-prod-transit-01/networking"
  }
}