data "http" "install" {
  url = "https://get.k3s.io"
}

resource "random_string" "tokens" {
  count   = 2
  length  = 22
  special = false
}

resource "shell_script" "default" {
  connection {
    type        = "ssh"
    user        = var.ssh.user
    private_key = var.ssh.private_key
    password    = var.ssh.password
    host        = var.ssh.host
  }

  provisioner "file" {
    content      = data.http.install.response_body
    destination = "${local.remote_dir}/install.sh"
  }

  lifecycle_commands {
    create = file("${path.module}/scripts/create.sh")
    read   = file("${path.module}/scripts/read.sh")
    update = file("${path.module}/scripts/update.sh")
    delete = file("${path.module}/scripts/delete.sh")
  }

  environment = {
    REMOTE_DIR = local.remote_dir
    K3S_TOKEN  = local.cluster.bootstrap_token
  }

  sensitive_environment = {
    SSH_USER = var.ssh.user
    SSH_HOST = var.ssh.host
  }
}
