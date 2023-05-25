resource "random_string" "token" {
  length  = 22
  special = false
}

module "k3s" {
  source  = "xunleii/k3s/module"
  k3s_version = "v1.0.0"
  cluster_domain = "k8s.appkins.net"
  cidr = {
    pods = "10.0.0.0/16"
    services = "10.1.0.0/16"
  }
  k3s_install_env_vars = {
    K3S_TOKEN = join(".", regex("^([a-z0-9]{6})([a-z0-9]{16})$", lower(random_string.token.result)))
  }
  drain_timeout = "30s"
  managed_fields = ["label", "taint"]
  global_flags = [
    "--tls-san k8s.appkins.net"
  ]
  servers = {
    bigboi = {
      ip = "192.168.50.75" // internal node IP
      connection = {
        host = "appkins.net" // public node IP
        user = "root"
        private_key = file("/Users/atkini01/.ssh/id_ed25519")
      }
      flags = [
        "--flannel-backend=none",
        "--no-flannel",
        "--disable-network-policy",
        "--disable-kube-proxy",
        "--disable=traefik",
        ]
      labels = {"node.kubernetes.io/type" = "master"}
      taints = {"node.k3s.io/type" = "server:NoSchedule"}
    }
  }
  agents = {
  }
}
