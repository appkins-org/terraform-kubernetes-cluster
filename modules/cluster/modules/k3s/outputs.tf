output "client_certificate" {
  value = base64decode(local.kube_config.client_certificate)
}

output "client_key" {
  value = base64decode(local.kube_config.client_key)
}

output "cluster_ca_certificate" {
  value = base64decode(local.kube_config.cluster_ca_certificate)
}

output "api_endpoint" {
  value = local.kube_config.api_endpoint
}

/* output "cluster" {
  value = terraform_data.cluster.output
}
 */
