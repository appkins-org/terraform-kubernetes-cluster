output "client_certificate" {
  value = module.k3s.client_certificate
}

output "client_key" {
  value = module.k3s.client_key
}

output "api_endpoint" {
  value = module.k3s.api_endpoint
}

output "cluster_ca_certificate" {
  value = module.k3s.cluster_ca_certificate
}
