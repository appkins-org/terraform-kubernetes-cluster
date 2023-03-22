terraform {
  required_version = ">= 0.13.0"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 0.1.0"
    }
  }
}

provider "helm" {
  kubernetes {
    host = "http://${var.local_api_endpoint}:6443"

    client_certificate     = module.cluster.client_certificate
    client_key             = module.cluster.client_key
    cluster_ca_certificate = module.cluster.cluster_ca_certificate
  }
}

variable "ssh_password" {
  type = string
}

variable "local_api_endpoint" {
  type = string
}

module "cluster" {
  source = "../"

  ssh = {
    username = "terraform"
    host     = "appkins.net"
    password = var.ssh_password
  }
}
