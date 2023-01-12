#----------------------------------------------------------------------------
# outputs - module outputs
#----------------------------------------------------------------------------

output "ip_address" {
  value = google_compute_global_address.pcln.address
}
