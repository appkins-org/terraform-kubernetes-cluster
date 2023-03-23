resource "random_string" "tokens" {
  count   = 2
  length  = 22
  special = false
}

/* resource "terraform_data" "install" {
  input = local.cluster

  connection {
    type        = "ssh"
    user        = var.ssh.user
    private_key = var.ssh.private_key
    password    = var.ssh.password
    host        = var.ssh.host
  }

  provisioner "remote-exec" {
    scripts = [
      "${path.module}/scripts/install-crio.sh",
      "${path.module}/scripts/install-kubeadm.sh"
    ]
  }
} */

# module "certs" {
#   source = "../certs"
# }

# resource "terraform_data" "certificates" {
#   input = {
#     ca    = module.certs.ca
#     admin = module.certs.admin
#   }
#   connection {
#     type        = "ssh"
#     user        = var.ssh.user
#     private_key = var.ssh.private_key
#     password    = var.ssh.password
#     host        = var.ssh.host
#   }

#   provisioner "file" {
#     content     = module.certs.ca.crt
#     destination = "${local.root}/ca.crt"
#   }

#   provisioner "file" {
#     content     = module.certs.ca.key
#     destination = "${local.root}/ca.key"
#   }

#   provisioner "file" {
#     content     = module.certs.admin.crt
#     destination = "${local.root}/admin-crt.pem"
#   }

#   provisioner "file" {
#     content     = module.certs.admin.key
#     destination = "${local.root}/admin-key.pem"
#   }

#   depends_on = [
#     module.certs,
#     terraform_data.install
#   ]
# }

resource "shell_script" "kubeadm" {
  connection {
    type        = "ssh"
    user        = var.ssh.user
    private_key = var.ssh.private_key
    password    = var.ssh.password
    host        = var.ssh.host
  }

  provisioner "file" {
    content     = templatefile("${path.module}/templates/config.yml", local.cluster)
    destination = "${local.remote_dir}/config.yml"
  }

  provisioner "file" {
    source = "${path.module}/scripts/remote/install.sh"
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
  }

  sensitive_environment = {
    SSH_USER = var.ssh.user
    SSH_HOST = var.ssh.host
  }
}

/* resource "terraform_data" "cluster" {
  input = local.cluster

  connection {
    type        = "ssh"
    user        = var.ssh.user
    private_key = var.ssh.private_key
    password    = var.ssh.password
    host        = var.ssh.host
  }

  provisioner "file" {
    content     = templatefile("${path.module}/templates/config.yml", local.cluster)
    destination = "${local.root}/config.yml"
  }

  provisioner "remote-exec" {
    inline = [
      # "sudo kubeadm init --pod-network-cidr=${local.pod_subnet} --upload-certs --cri-socket unix:///var/run/crio/crio.sock --control-plane-endpoint=k8s.appkins.net --skip-phases=addon/kube-proxy",
      "sudo kubeadm init --config ${local.root}/config.yml",
      # "sudo kubectl config set-cluster default-cluster --server=https://${var.local_api_endpoint}:6443 --certificate-authority ${local.root}/ca.crt --embed-certs --kubeconfig=/etc/kubernetes/admin.conf",
      # "sudo kubectl config set-credentials default-admin --client-key ${local.root}/admin-key.pem --client-certificate ${local.root}/admin-crt.pem --embed-certs --kubeconfig=/etc/kubernetes/admin.conf",
      # "sudo kubectl config set-context default-system --cluster default-cluster --user default-admin --kubeconfig=/etc/kubernetes/admin.conf",
      # "sudo kubectl config use-context default-system --kubeconfig=/etc/kubernetes/admin.conf"
    ]
  }

  depends_on = [
    terraform_data.install
  ]
}

data "external" "kube_config" {
  program = ["bash", "${path.module}/scripts/kube-config.sh"]

  query = {
    ssh_user = var.ssh.user
    ssh_host = var.ssh.host
  }

  depends_on = [
    terraform_data.cluster
  ]
} */
