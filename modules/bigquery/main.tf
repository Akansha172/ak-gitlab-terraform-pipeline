resource "google_bigquery_dataset" "dataset" {
  for_each   = var.id_map
  dataset_id = each.value
  project    = var.project_id
  location   = var.location
  #default_table_expiration_ms = 3600000
}

###############
#  Big Query  #
###############
resource "google_bigquery_table" "table" {
  for_each            = var.id_map
  dataset_id          = google_bigquery_dataset.dataset[each.key].dataset_id
  table_id            = each.key
  deletion_protection = var.deletion_protection

  schema = <<EOF
[
  {
    "name": "ID",
    "type": "INT64",
    "mode": "NULLABLE",
    "description": "Item ID"
  },
  {
    "name": "Item",
    "type": "STRING",
    "mode": "NULLABLE"
  }
]
EOF
}