# ------------------------------------------------------------------------------
# Instance Group Templates

resource "google_compute_instance_template" "guse4-rcnginxfe-0-v5-it" {
  name         = "guse4-rcnginxfe-0-v5-it"
  region       = "us-east4"
  machine_type = "n1-standard-2"

  labels = {
    dns = ""
  }

  metadata = {
    cell             = "guse4-poc"
    clusterid        = "0"
    consul_acl_token = "VTJGc2RHVmtYMTlOaFI3dVdvek1PM0pZaW1lY0FtVFdwSkx5V29raTFrRjFEOXkvQStqdnJLRnNySkh5aVF2WQpYSUJDZFV1Q293eWp4MnNSVWs4SDZnPT0K"
    product          = "rc"
    servicename      = "frontend"

  }

  tags = ["frontend-application", "frontend-nginx", "healthcheck", "infrastructure"]

  disk {
    auto_delete  = true
    boot         = true
    device_name  = "boot"
    disk_size_gb = 32
    disk_type    = "pd-ssd"
    labels       = {}
    mode         = "READ_WRITE"
    source_image = "projects/pcln-pl-infra-nonprod/global/images/family/pcln-rc-nginx"
    type         = "PERSISTENT"
  }

  network_interface {
    network    = "default"
    subnetwork = "default"
  }

}

resource "google_compute_instance_template" "gnae1-rcnginxfe-0-v5-it" {
  name         = "gnae1-rcnginxfe-0-v5-it"
  region       = "northamerica-northeast1"
  machine_type = "n1-standard-2"

  labels = {
    dns = ""
  }

  metadata = {
    cell             = "gnae1-poc"
    clusterid        = "0"
    consul_acl_token = "VTJGc2RHVmtYMTlOaFI3dVdvek1PM0pZaW1lY0FtVFdwSkx5V29raTFrRjFEOXkvQStqdnJLRnNySkh5aVF2WQpYSUJDZFV1Q293eWp4MnNSVWs4SDZnPT0K"
    product          = "rc"
    servicename      = "frontend"

  }

  tags = ["frontend-application", "frontend-nginx", "healthcheck", "infrastructure"]

  disk {
    auto_delete  = true
    boot         = true
    device_name  = "boot"
    disk_size_gb = 32
    disk_type    = "pd-ssd"
    labels       = {}
    mode         = "READ_WRITE"
    source_image = "projects/pcln-pl-infra-nonprod/global/images/family/pcln-rc-nginx"
    type         = "PERSISTENT"
  }

  network_interface {
    network    = "default"
    subnetwork = "default"
  }
}

resource "google_compute_instance_template" "gsae1-rcnginxfe-0-v5-it" {
  name         = "gsae1-rcnginxfe-0-v5-it"
  region       = "southamerica-east1"
  machine_type = "n1-standard-2"

  labels = {
    dns = ""
  }

  metadata = {
    cell             = "gsae1-poc"
    clusterid        = "0"
    consul_acl_token = "VTJGc2RHVmtYMTlOaFI3dVdvek1PM0pZaW1lY0FtVFdwSkx5V29raTFrRjFEOXkvQStqdnJLRnNySkh5aVF2WQpYSUJDZFV1Q293eWp4MnNSVWs4SDZnPT0K"
    product          = "rc"
    servicename      = "frontend"

  }

  tags = ["frontend-application", "frontend-nginx", "healthcheck", "infrastructure"]

  disk {
    auto_delete  = true
    boot         = true
    device_name  = "boot"
    disk_size_gb = 32
    disk_type    = "pd-ssd"
    labels       = {}
    mode         = "READ_WRITE"
    source_image = "projects/pcln-pl-infra-nonprod/global/images/family/pcln-rc-nginx"
    type         = "PERSISTENT"
  }

  network_interface {
    network    = "default"
    subnetwork = "default"
  }
}

# ------------------------------------------------------------------------------
# Instance Group Manager

resource "google_compute_region_instance_group_manager" "guse4-rcnginxfe-0igm" {
  name               = "guse4-rcnginxfe-0igm"
  base_instance_name = "guse4-rcnginxfe-0"
  region             = "us-east4"

  version {
    instance_template = google_compute_instance_template.guse4-rcnginxfe-0-v5-it.self_link
  }
}

resource "google_compute_region_instance_group_manager" "gnae1-rcnginxfe-0igm" {
  name               = "gnae1-rcnginxfe-0igm"
  base_instance_name = "gnae1-rcnginxfe-0"
  region             = "northamerica-northeast1"

  version {
    instance_template = google_compute_instance_template.gnae1-rcnginxfe-0-v5-it.self_link
  }
}

resource "google_compute_region_instance_group_manager" "gsae1-rcnginxfe-0igm" {
  name               = "gsae1-rcnginxfe-0igm"
  base_instance_name = "gsae1-rcnginxfe-0"
  region             = "southamerica-east1"

  version {
    instance_template = google_compute_instance_template.gsae1-rcnginxfe-0-v5-it.self_link
  }
}
