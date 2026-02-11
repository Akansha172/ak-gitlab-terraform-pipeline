terraform {
  backend "gcs" {
    bucket = "org-bucket-prod-tfstate"
    prefix = "org-network-prod-01/firewall"
  }
}