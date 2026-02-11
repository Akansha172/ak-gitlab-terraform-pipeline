output "folder_id" {
  value = { for k, v in google_folder.folders : k => v.id }
}