## Internal HTTP/s loadbalancer
![Maintained by Priceline.com](https://img.shields.io/badge/maintained%20by-priceline.com-blue)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D0.13-blue.svg)

### Examples
Create the internal static IP:
```sh
module "guse4-internallb-intip" {
  source = "git::https://github.com/pcln/terraform-gcp-compute_address.git//modules/compute_address_tfo"

  clusterid    = "a"
  ip_addresses = [""]
  name_suffix  = "-intip"
  servertype   = "internallb"
  subnet_type  = "private"

  # pass through
  env     = var.env
  project = var.project
  region  = var.region
}
```

Create loadbalancer:
```sh
# define the backend
data "google_compute_instance_group" "backend" {
  name = "guse4-master-qa-igb"
  zone = "us-east4-b"
}

# define the internal loabbalancer
module "guse4-master-internallb" {
  source = "git::https://github.com/pcln/terraform-gcp-gclb.git//modules/internal-http"

  name    = "guse4-internallb"
  ip_address = module.guse4-internallb-intip.ip_addresses[0]
  use_tls = false

  backend_services = [
    {
      group = data.google_compute_instance_group.backend.self_link,
      balancing_mode = "UTILIZATION",
      capacity_scaler = 1.0
    },
  ]

  # pass through
  env     = var.env
  project = var.project
  region  = var.region
}

```

### Usage
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudcost_labels"></a> [cloudcost\_labels](#module\_cloudcost\_labels) | git::https://github.com/pcln/terraform-curl-cloudcost_labels.git//modules/cloudcost_labels |  |
| <a name="module_gcp_varlib"></a> [gcp\_varlib](#module\_gcp\_varlib) | git::https://github.com/pcln/terraform-gcp-varlib.git//modules/gcp_varlib |  |

## Resources

| Name | Type |
|------|------|
| [google-beta_google_compute_forwarding_rule.http](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_forwarding_rule) | resource |
| [google-beta_google_compute_forwarding_rule.https](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_forwarding_rule) | resource |
| [google-beta_google_compute_region_backend_service.pcln](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_region_backend_service) | resource |
| [google-beta_google_compute_region_health_check.http](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_region_health_check) | resource |
| [google-beta_google_compute_region_health_check.tcp](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_region_health_check) | resource |
| [google-beta_google_compute_region_target_http_proxy.http](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_region_target_http_proxy) | resource |
| [google-beta_google_compute_region_target_https_proxy.https](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_region_target_https_proxy) | resource |
| [google-beta_google_compute_region_url_map.pcln](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_region_url_map) | resource |
| [google_compute_network.pcln](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network) | data source |
| [google_compute_subnetwork.pcln](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_subnetwork) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backend_protocol"></a> [backend\_protocol](#input\_backend\_protocol) | A named port on a backend instance group representing the port for communication to the backend VMs in that group. | `string` | `"HTTP"` | no |
| <a name="input_backend_service_name"></a> [backend\_service\_name](#input\_backend\_service\_name) | Backend Service name. Overrides standard naming convention | `string` | `""` | no |
| <a name="input_backend_services"></a> [backend\_services](#input\_backend\_services) | n/a | <pre>list(object({<br>    group           = string<br>    balancing_mode  = string<br>    capacity_scaler = number<br>  }))</pre> | `[]` | no |
| <a name="input_custom_name_override"></a> [custom\_name\_override](#input\_custom\_name\_override) | Allows to override loadbalancer components names. | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | `"poc"` | no |
| <a name="input_forwarding_rule_name"></a> [forwarding\_rule\_name](#input\_forwarding\_rule\_name) | Forwarding rule name. Overrides standard naming convention | `string` | `""` | no |
| <a name="input_health_check"></a> [health\_check](#input\_health\_check) | Health check to determine whether instances are responsive and able to do work, could be (`tcp` or `http`) | <pre>object({<br>    type = string<br>    port = string<br>  })</pre> | <pre>{<br>  "port": "80",<br>  "type": "tcp"<br>}</pre> | no |
| <a name="input_health_check_name"></a> [health\_check\_name](#input\_health\_check\_name) | Health check name. Overrides standard naming convention | `string` | `""` | no |
| <a name="input_ip_address"></a> [ip\_address](#input\_ip\_address) | The IP address that this forwarding rule is serving on behalf of. | `string` | `""` | no |
| <a name="input_ip_protocol"></a> [ip\_protocol](#input\_ip\_protocol) | The IP protocol to which this rule applies. | `string` | `"TCP"` | no |
| <a name="input_load_balancer_name"></a> [load\_balancer\_name](#input\_load\_balancer\_name) | Loadbalancer name. Overrides standard naming convention | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `""` | no |
| <a name="input_network_name_override"></a> [network\_name\_override](#input\_network\_name\_override) | Override the network name | `string` | `""` | no |
| <a name="input_network_project_override"></a> [network\_project\_override](#input\_network\_project\_override) | Override the network name | `string` | `""` | no |
| <a name="input_network_tier"></a> [network\_tier](#input\_network\_tier) | Network tier to use for loadbalancer. | `string` | `"PREMIUM"` | no |
| <a name="input_network_type"></a> [network\_type](#input\_network\_type) | Used to identify the pcln network (net, valohai or qubole) | `string` | `"net"` | no |
| <a name="input_port_name"></a> [port\_name](#input\_port\_name) | A named port on a backend instance group representing the port for communication to the backend VMs in that group. | `string` | `"http"` | no |
| <a name="input_port_range"></a> [port\_range](#input\_port\_range) | n/a | `string` | `"80"` | no |
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `""` | no |
| <a name="input_ssl_certificates"></a> [ssl\_certificates](#input\_ssl\_certificates) | n/a | `list` | `[]` | no |
| <a name="input_subnet_type"></a> [subnet\_type](#input\_subnet\_type) | a subnet type | `string` | `"private"` | no |
| <a name="input_target_proxy_name"></a> [target\_proxy\_name](#input\_target\_proxy\_name) | HTTP/S proxy name. Overrides standard naming convention | `string` | `""` | no |
| <a name="input_team"></a> [team](#input\_team) | Name of the team that owns the resource | `string` | `""` | no |
| <a name="input_url_map_name"></a> [url\_map\_name](#input\_url\_map\_name) | Url map name. Overrides standard naming convention | `string` | `""` | no |
| <a name="input_use_tls"></a> [use\_tls](#input\_use\_tls) | Use TLS with loadbalncer | `bool` | `true` | no |
| <a name="input_user_labels"></a> [user\_labels](#input\_user\_labels) | User defined labels to apply to the loadbalancer components | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ip_address"></a> [ip\_address](#output\_ip\_address) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
