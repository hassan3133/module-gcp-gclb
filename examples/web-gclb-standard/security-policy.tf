
resource "google_compute_security_policy" "pcln" {
  name = "security-policy"

  rule {
    action      = "allow"
    description = "Apigee"
    preview     = false
    priority    = 32

    match {
      versioned_expr = "SRC_IPS_V1"

      config {
        src_ip_ranges = [
          "35.229.113.32/32",
          "35.237.98.15/32",
        ]
      }
    }
  }
  rule {
    action      = "allow"
    description = "Catchpoint Rule 1\\n# Sydney, AU\\n# Montreal, CA\\n# Berlin, DE"
    preview     = false
    priority    = 30

    match {
      versioned_expr = "SRC_IPS_V1"

      config {
        src_ip_ranges = [
          "195.93.242.2/32",
          "195.93.242.3/32",
          "65.151.184.184/32",
          "74.121.167.132/32",
          "74.121.167.133/32",
        ]
      }
    }
  }
  rule {
    action      = "allow"
    description = "Catchpoint Rule 2\\n# London, UK\\n# Dublin, IE\\n# Auckland, NZ"
    preview     = false
    priority    = 31

    match {
      versioned_expr = "SRC_IPS_V1"

      config {
        src_ip_ranges = [
          "210.48.32.17/32",
          "210.48.32.18/32",
          "52.56.71.32/32",
          "78.137.191.117/32",
          "78.137.191.118/32",
        ]
      }
    }
  }
  rule {
    action      = "allow"
    description = "CorpExternal"
    preview     = false
    priority    = 10

    match {
      versioned_expr = "SRC_IPS_V1"

      config {
        src_ip_ranges = [
          "38.88.255.106/32",
          "64.6.22.251/32",
          "64.6.23.1/32",
          "64.6.29.251/32",
        ]
      }
    }
  }
  rule {
    action      = "allow"
    description = "Fastly 1"
    preview     = false
    priority    = 20

    match {
      versioned_expr = "SRC_IPS_V1"

      config {
        src_ip_ranges = [
          "103.244.50.0/24",
          "103.245.222.0/23",
          "103.245.224.0/24",
          "23.235.32.0/20",
          "43.249.72.0/22",
        ]
      }
    }
  }
  rule {
    action      = "allow"
    description = "Fastly 2"
    preview     = false
    priority    = 21

    match {
      versioned_expr = "SRC_IPS_V1"

      config {
        src_ip_ranges = [
          "104.156.80.0/20",
          "151.101.0.0/16",
          "157.52.64.0/18",
          "172.111.64.0/18",
          "185.31.16.0/22",
        ]
      }
    }
  }
  rule {
    action      = "allow"
    description = "Fastly 3"
    preview     = false
    priority    = 22

    match {
      versioned_expr = "SRC_IPS_V1"

      config {
        src_ip_ranges = [
          "185.31.16.0/22",
          "199.232.0.0/16",
          "199.27.72.0/21",
          "202.21.128.0/24",
          "203.57.145.0/24",
        ]
      }
    }
  }
  rule {
    action      = "allow"
    description = "Fastly Nginx"
    preview     = false
    priority    = 15

    match {
      versioned_expr = "SRC_IPS_V1"

      config {
        src_ip_ranges = [
          "35.194.89.117/32",
        ]
      }
    }
  }
  rule {
    action      = "allow"
    description = "Google Health Checks"
    preview     = false
    priority    = 11

    match {
      versioned_expr = "SRC_IPS_V1"

      config {
        src_ip_ranges = [
          "130.211.0.0/22",
          "209.85.152.0/22",
          "209.85.204.0/22",
          "35.191.0.0/16",
        ]
      }
    }
  }
  rule {
    action      = "deny(403)"
    description = "Default rule, higher priority overrides it"
    preview     = false
    priority    = 2147483647

    match {
      versioned_expr = "SRC_IPS_V1"

      config {
        src_ip_ranges = [
          "*",
        ]
      }
    }
  }

  timeouts {}
}
