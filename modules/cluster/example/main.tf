variable "local_api_endpoint" {
  type = string
}

module "cluster" {
  source = "../"

  ssh = {
    user            = "root"
    host            = "appkins.net"
    ssh_private_key = file("~/.ssh/id_ed25519")
  }
}

output "cluster" {
  value = module.cluster
}
