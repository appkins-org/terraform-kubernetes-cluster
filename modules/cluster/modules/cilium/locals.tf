locals {
  values = {
    bpf          = { masquerade = true }
    externalIPs  = { enabled = true }
    nodePort     = { enabled = true }
    image        = { pullPolicy = "IfNotPresent" }
    ipam         = { mode = "kubernetes" }
    hostServices = { enabled = true }
    hostPort     = { enabled = true }
    hubble = {
      enabled = true
      relay   = { enabled = true, replicas = 1 }
    }
    cluster = {
      id   = 0
      name = "kubernetes"
    }
    encryption = {
      nodeEncryption = false
    }
    k8sServiceHost       = "k8s.appkins.net"
    k8sServicePort       = 6443
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
    ingressController = {
      enabled = true
      default = true
    }
    gatewayAPI = {
      enabled = false
    }
    clustermesh = {
      config = {
        enabled = true
      }
    }
  }
}
