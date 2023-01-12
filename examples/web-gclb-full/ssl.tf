# ------------------------------------------------------------------------------
# SSL

data "google_compute_ssl_certificate" "pcln" {
  name = "wild-priceline-2020"
}

data "google_compute_ssl_policy" "pcln" {
  name = "modern-ssl-policy"
}



# ------------------------------------------------------------------------------
# resource "google_compute_ssl_certificate" "pcln" {
#   name        = "wild-priceline-2020"
#   certificate = "${file("../../ssl_certs/wild-priceline-2020.key")}"
#   private_key = "${file("../../ssl_certs/wild-priceline-2020.crt")}"
# }
#
# resource "google_compute_ssl_policy" "pcln" {
#   name            = "modern-ssl-policy"
#   custom_features = []
#   min_tls_version = "TLS_1_2"
#   profile         = "MODERN"
# }
