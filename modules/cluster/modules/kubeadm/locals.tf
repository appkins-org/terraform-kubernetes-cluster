locals {
  cidr_lookup = {
    calico  = "192.168.0.0/16"
    flannel = "10.244.0.0/16"
    cilium  = "10.217.0.0/16"
  }

  pod_subnet = lookup(local.cidr_lookup, var.network_plugin, var.pod_subnet)

  cluster = {
    id         = var.cluster_id
    domain     = var.domain
    public_ip  = var.public_ip,
    private_ip = var.private_ip
    version    = var.cluster_version

    bootstrap_token = join(".", regex("^([a-z0-9]{6})([a-z0-9]{16})$", lower(random_string.tokens[0].result)))
    admin_token     = join(".", regex("^([a-z0-9]{6})([a-z0-9]{16})$", lower(random_string.tokens[1].result)))

    pod_subnet = lookup(local.cidr_lookup, var.network_plugin, var.pod_subnet)

    local_api_endpoint = var.local_api_endpoint

    extra_volumes = null

    root = local.root
  }

  root = var.ssh.user == "root" ? "/root" : "/home/${var.ssh.user}"
}
