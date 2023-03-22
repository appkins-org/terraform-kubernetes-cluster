output "cluster" {
  value = module.kubeadm.cluster
}

output "client_certificate" {
  value = module.kubeadm.client_certificate
}

output "client_key" {
  value = module.kubeadm.client_key
}

output "cluster_ca_certificate" {
  value = module.kubeadm.cluster_ca_certificate
}
