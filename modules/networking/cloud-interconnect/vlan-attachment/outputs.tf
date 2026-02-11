output "interconnect_pairing_keys" {
  description = "Pairing keys for interconnect attachments"
  value       = { for k, v in google_compute_interconnect_attachment.attachment : k => v.pairing_key }
}

output "interconnect_self_links" {
  description = "Self link for interconnect attachments"
  value       = { for k, v in google_compute_interconnect_attachment.attachment : k => v.self_link }
}