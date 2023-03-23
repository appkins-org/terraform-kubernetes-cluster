variable "local_api_endpoint" {
  type = string
}

variable "onepassword_token" {
}

variable "github" {}

variable "onepassword_credentials" {
}

variable "cloudflare" {}

variable "external_ips" {}

module "cluster" {
  source = "../"

  cluster = {
    ssh = {
      user            = "root"
      host            = "appkins.net"
      ssh_private_key = file("~/.ssh/id_ed25519")
    }
    onepassword = {
      credentials = var.onepassword_credentials
      token       = var.onepassword_token
    }
  }

  github = var.github

  ingress = {
    external_ips = var.external_ips
  }

  cloudflare = var.cloudflare
}

output "cluster" {
  value = module.cluster
}
