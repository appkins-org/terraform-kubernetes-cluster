provider "kind" {}

locals {
  k8s_config_path = pathexpand("~/.kube/config")
}

# creating a cluster with kind of the name "test-cluster" with kubernetes version v1.18.4 and two nodes
resource "kind_cluster" "test-cluster" {
  name           = "test-cluster"
  kubeconfig_path = local.k8s_config_path
  node_image     = "kindest/node:v1.18.4"
  wait_for_ready = true
  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"
    node {
      role = "control-plane"

      kubeadm_config_patches = [
          "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"ingress-ready=true\"\n",
          yamlencode({ kind = "InitConfiguration"
            nodeRegistration = {
              criSocket = "unix:///run/crio/crio.sock"
              kubeletExtraArgs = {
                cgroup-driver = "cgroupfs" }}})
      ]

      extra_port_mappings {
          container_port = 80
          host_port      = 80
      }
      extra_port_mappings {
          container_port = 443
          host_port      = 443
      }
    }
    node {
      role = "worker"

      kubeadm_config_patches = [
          yamlencode({ kind = "InitConfiguration"
            nodeRegistration = {
              criSocket = "unix:///run/crio/crio.sock"
              kubeletExtraArgs = {
                cgroup-driver = "cgroupfs" }}})
      ]
    }
  }
  provisioner "local-exec" {
    command = "kubectl config set-context kind-test-cluster"
  }
}
