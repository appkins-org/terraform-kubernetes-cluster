output "cluster" {
  value = module.kubeadm.cluster
}

output "client_certificate" {
  value = module.kubeadm.client_certificate
}

output "client_key" {
  value = module.kubeadm.client_key
}

output "api_endpoint" {
  value = module.kubeadm.api_endpoint
}

output "cluster_ca_certificate" {
  value = module.kubeadm.cluster_ca_certificate
}

output "kube_config" {
  value = module.kubeadm.kube_config
}
