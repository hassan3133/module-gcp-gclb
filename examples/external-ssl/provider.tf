provider "google" {
  project     = var.project
  credentials = base64decode(var.gcp_service_account)
}

provider "google-beta" {
  project     = var.project
  credentials = base64decode(var.gcp_service_account)
}
