output "client_certificate" {
  value = module.certs.admin.crt
}

output "client_key" {
  value = module.certs.admin.key
}

output "cluster_ca_certificate" {
  value = module.certs.ca.crt
}

output "cluster" {
  value = terraform_data.cluster.output
}
