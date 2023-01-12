# ------------------------------------------------------------------------------
# SSL certificate
# ------------------------------------------------------------------------------

data "google_secret_manager_secret_version" "pl-valohai-lb-crt" {
  secret = "pl-valohai-lb-crt"
}

data "google_secret_manager_secret_version" "pl-valohai-lb-key" {
  secret = "pl-valohai-lb-key"
}

resource "google_compute_region_ssl_certificate" "pcln" {
  name        = "guse4-internallb-certificate"
  region      = var.region
  certificate = data.google_secret_manager_secret_version.pl-valohai-lb-crt.secret_data
  private_key = data.google_secret_manager_secret_version.pl-valohai-lb-key.secret_data

  lifecycle {
    create_before_destroy = true
  }
}
