locals {
  values = {
    bpf = {
      masquerade = true
    }
    cluster = {
      id = 0
      name = "kubernetes"
    }
    encryption = {
      nodeEncryption = false
    }
    k8sServiceHost = "k8s.appkins.net"
    k8sServicePort = 6443
    kubeProxyReplacement = "strict"
    operator = {
      replicas = 1
    }
    serviceAccounts = {
      cilium = {
        name = "cilium"
      }
      operator = {
        name = "cilium-operator"
      }
    }
    tunnel = "vxlan"
  }
}
