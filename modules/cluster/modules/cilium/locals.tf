locals {

  pools = {
    apiVersion = "cilium.io/v2alpha1"
    kind = "CiliumLoadBalancerIPPool"
    metadata = {
      name = "default"
    }
    spec = {
      cidrs = [{ cidr = "10.0.10.0/24" }]
    }
  }

  bgp_config = {
    peers = [{
      peer-address = "172.17.9.200"
      peer-asn = 64512
      my-asn = 64513
    }]
    address-pools = [{
      name = "default"
      protocol = "bgp"
      addresses = ["192.168.50.75-192.168.50.77"]
    }]
  }
  values = {
   bgp = {
      enabled = true
      announce = {
        loadbalancerIP = true
        podCIDR        = true
      }
    }
    bgpControlPlane = { enabled = true }
    bpf          = { masquerade = true, lbExternalClusterIP = true }
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
      prometheus = { enabled = true }
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
      loadbalancerMode = "shared"
    }
    gatewayAPI = {
      enabled = false
    }
    clustermesh = {
      config = {
        enabled = true
      }
    }
    prometheus = { enabled = true }
  }
}
