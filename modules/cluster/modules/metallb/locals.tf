locals {
  values = {
  }

  address_pools = {
    apiVersion = "metallb.io/v1beta1"
    kind       = "IPAddressPool"
    metadata = {
      name      = "private-pool"
      namespace = "metallb-system"
    }
    spec = {
      addresses = ["192.168.50.75-192.168.50.77"]
    }
  }
}
