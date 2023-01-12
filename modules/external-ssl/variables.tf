variable "backend_service_name" {
  default = ""
}

variable "backends" {
  description = <<EOF
  List of backends, should be a map of key-value pairs for each backend, must have the group key.
   Example
   backends = [
     {
       group           =  google_compute_instance_group_manager.default.instance_group
       balancing_mode  = "UTILIZATION"
       max_utilization = 1.0
       capacity_scaler = 1.0
     }
   ]
  EOF
  type        = list(map(string))
}

variable "backend_service_protocol" {
  default     = "TCP"
  description = "The protocol this BackendService uses to communicate with backends."
  type        = string

  validation {
    condition     = contains(["TCP", "SSL"], var.backend_service_protocol)
    error_message = "Possible values are TCP and SSL."
  }
}

variable "backend_service_timeout_sec" {
  default     = 30
  description = "How many seconds to wait for the backend before considering it a failed request."
  type        = number
}

variable "custom_name_override" {
  default     = false
  description = "Override name for the load balancer and associated resources."
  type        = bool
}

variable "global_address_name" {
  default     = ""
  description = "Name of the resource."
  type        = string
}

variable "global_forwarding_rule_name" {
  default     = ""
  description = "Name of the resource."
  type        = string
}

variable "health_check_name" {
  default     = ""
  description = "Name of the resource."
  type        = string
}

variable "health_check_timeout_sec" {
  default     = 5
  description = "How long (in seconds) to wait before claiming failure. It is invalid for timeoutSec to have greater value than checkIntervalSec."
  type        = number
}

variable "health_check_check_interval_sec" {
  default     = 5
  description = "How often (in seconds) to send a health check."
  type        = number
}

variable "ip_version" {
  default     = "IPV4"
  description = " The IP Version that will be used by this address."
  type        = string

  validation {
    condition     = contains(["IPV4", "IPV6"], var.ip_version)
    error_message = "Possible values are IPV4 and IPV6."
  }
}

variable "name" {
  description = "Name for associated resources."
  type        = string
}

variable "port_name" {
  default     = "https"
  description = "Name of backend port. The same name should appear in the instance groups referenced by this service."
  type        = string
}

variable "port_range" {
  default     = "443"
  description = "Applicable only when IPProtocol is TCP, UDP, or SCTP, only packets addressed to ports in the specified range will be forwarded to target. https://cloud.google.com/load-balancing/docs/load-balancing-overview#summary-of-google-cloud-load-balancers."
  type        = string

  validation {
    condition     = contains(["25", "43", "110", "143", "195", "443", "465", "587", "700", "993", "995", "1883", "3389", "5222", "5432", "5671", "5672", "5900", "5901", "6379", "8085", "8099", "9092", "9200", "9300"], var.port_range)
    error_message = "Please, assign a valid port: 25, 43, 110, 143, 195, 443, 465, 587, 700, 993, 995, 1883, 3389, 5222, 5432, 5671, 5672, 5900, 5901, 6379, 8085, 8099, 9092, 9200, 9300."
  }
}

variable "port_tcp_health_check" {
  default     = "443"
  description = "The TCP port number for the TCP health check request."
  type        = string
}

variable "project" {
  description = "The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
  type        = string
}

variable "ssl_certificates" {
  type        = list
  description = "A list of SslCertificate resources that are used to authenticate connections between users and the load balancer. At least one SSL certificate must be specified."
}

variable "ssl_policy" {
  default     = ""
  description = "A reference to the SslPolicy resource that will be associated with the TargetSslProxy resource."
  type        = string
}

variable "target_ssl_proxy_name" {
  default     = ""
  description = "Name of the resource."
  type        = string
}
