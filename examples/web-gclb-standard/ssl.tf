# ------------------------------------------------------------------------------
# SSL

data "google_compute_ssl_certificate" "pcln" {
  name = "wild-priceline-2020"
}

data "google_compute_ssl_policy" "pcln" {
  name = "modern-ssl-policy"
}
