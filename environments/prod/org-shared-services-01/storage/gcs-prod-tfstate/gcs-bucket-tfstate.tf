##################
#  GCS Buckets   #
##################
module "buckets" {
  source  = "../../../../../modules/storage/gcs-bucket"
  buckets = var.buckets
}
