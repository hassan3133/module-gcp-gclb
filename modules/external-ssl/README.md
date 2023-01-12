<!-- BEGIN_TF_DOCS -->
#### Modules

No modules.

#### Resources

| Name | Type |
|------|------|
| [google_compute_backend_service.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_backend_service) | resource |
| [google_compute_global_address.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_compute_global_forwarding_rule.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_forwarding_rule) | resource |
| [google_compute_health_check.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_health_check) | resource |
| [google_compute_target_ssl_proxy.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_target_ssl_proxy) | resource |

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backends"></a> [backends](#input_backends) | List of backends, should be a map of key-value pairs for each backend, must have the group key.<br>   Example<br>   backends = [<br>     {<br>       group           =  google_compute_instance_group_manager.default.instance_group<br>       balancing_mode  = "UTILIZATION"<br>       max_utilization = 1.0<br>       capacity_scaler = 1.0<br>     }<br>   ] | `list(map(string))` | n/a | yes |
| <a name="input_name"></a> [name](#input_name) | Name for associated resources. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input_project) | The ID of the project in which the resource belongs. If it is not provided, the provider project is used. | `string` | n/a | yes |
| <a name="input_ssl_certificates"></a> [ssl_certificates](#input_ssl_certificates) | A list of SslCertificate resources that are used to authenticate connections between users and the load balancer. At least one SSL certificate must be specified. | `list` | n/a | yes |
| <a name="input_backend_service_name"></a> [backend_service_name](#input_backend_service_name) | n/a | `string` | `""` | no |
| <a name="input_backend_service_protocol"></a> [backend_service_protocol](#input_backend_service_protocol) | The protocol this BackendService uses to communicate with backends. | `string` | `"TCP"` | no |
| <a name="input_backend_service_timeout_sec"></a> [backend_service_timeout_sec](#input_backend_service_timeout_sec) | How many seconds to wait for the backend before considering it a failed request. | `number` | `30` | no |
| <a name="input_custom_name_override"></a> [custom_name_override](#input_custom_name_override) | Override name for the load balancer and associated resources. | `bool` | `false` | no |
| <a name="input_global_address_name"></a> [global_address_name](#input_global_address_name) | Name of the resource. | `string` | `""` | no |
| <a name="input_global_forwarding_rule_name"></a> [global_forwarding_rule_name](#input_global_forwarding_rule_name) | Name of the resource. | `string` | `""` | no |
| <a name="input_health_check_check_interval_sec"></a> [health_check_check_interval_sec](#input_health_check_check_interval_sec) | How often (in seconds) to send a health check. | `number` | `5` | no |
| <a name="input_health_check_name"></a> [health_check_name](#input_health_check_name) | Name of the resource. | `string` | `""` | no |
| <a name="input_health_check_timeout_sec"></a> [health_check_timeout_sec](#input_health_check_timeout_sec) | How long (in seconds) to wait before claiming failure. It is invalid for timeoutSec to have greater value than checkIntervalSec. | `number` | `5` | no |
| <a name="input_ip_version"></a> [ip_version](#input_ip_version) | The IP Version that will be used by this address. | `string` | `"IPV4"` | no |
| <a name="input_port_name"></a> [port_name](#input_port_name) | Name of backend port. The same name should appear in the instance groups referenced by this service. | `string` | `"https"` | no |
| <a name="input_port_range"></a> [port_range](#input_port_range) | Applicable only when IPProtocol is TCP, UDP, or SCTP, only packets addressed to ports in the specified range will be forwarded to target. https://cloud.google.com/load-balancing/docs/load-balancing-overview#summary-of-google-cloud-load-balancers. | `string` | `"443"` | no |
| <a name="input_port_tcp_health_check"></a> [port_tcp_health_check](#input_port_tcp_health_check) | The TCP port number for the TCP health check request. | `string` | `"443"` | no |
| <a name="input_ssl_policy"></a> [ssl_policy](#input_ssl_policy) | A reference to the SslPolicy resource that will be associated with the TargetSslProxy resource. | `string` | `""` | no |
| <a name="input_target_ssl_proxy_name"></a> [target_ssl_proxy_name](#input_target_ssl_proxy_name) | Name of the resource. | `string` | `""` | no |

#### Outputs

| Name | Description |
|------|-------------|
| <a name="output_global_address"></a> [global_address](#output_global_address) | n/a |
<!-- END_TF_DOCS -->