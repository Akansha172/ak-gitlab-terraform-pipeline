##################
#  GCP Folders   #
##################
module "folders" {
  source  = "../../../../modules/ou/gcp-folder"
  folders = var.folders
}
