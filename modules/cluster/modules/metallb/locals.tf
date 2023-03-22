locals {
  values = {
    configInline = {
        address-pools = [{
            name = "default"
            protocol = "layer2"
            addresses = ["192.168.50.75-192.168.50.77"]
        }]
    }
  }
}
