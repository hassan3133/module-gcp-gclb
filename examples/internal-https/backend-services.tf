# ------------------------------------------------------------------------------
# backend
# ------------------------------------------------------------------------------

data "google_compute_instance_group" "backend" {
  name = "guse4-master-qa-igb"
  zone = "us-east4-b"
}

# ------------------------------------------------------------------------------
#  backend instance
# ------------------------------------------------------------------------------

module "guse4-master-qa" {
  source = "git::https://github.com/pcln/terraform-gcp-compute_instance.git//modules/compute_instance_tfo"

  module_count = 1
  cell         = "${var.env}a"
  clusterid    = "a"
  servertype   = "master"
  subnet_type  = "private"
  image        = "centos-7"
  internal_ips = module.guse4-master-intip.ip_addresses

  # pass through
  env     = var.env
  project = var.project
  region  = var.region

  # set the qubole VPC
  network_type = "valohai"

  labels = {
    owner   = "dataservices_priceline_com",
    product = "data",
    team    = "data_svcs"
  }

  no_default_tags = true

  tags = [
    "valohai"
  ]
}

# ------------------------------------------------------------------------------
#  backend unmanaged instance group
# ------------------------------------------------------------------------------

module "guse4-master-ig" {
  source = "git::https://github.com/pcln/terraform-gcp-compute_instance.git//modules/compute_instance_group_tfo"

  clusterid                 = "a"
  servertype                = "master"
  compute_instances_by_zone = module.guse4-master-qa.compute_instances_by_zone

  named_ports = [
    {
      name = "http"
      port = "8000"
    }
  ]

  # pass through
  env     = var.env
  project = var.project
  region  = var.region
}
