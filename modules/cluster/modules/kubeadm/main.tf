resource "random_string" "tokens" {
  count   = 2
  length  = 22
  special = false
}

resource "terraform_data" "install" {
  input = local.cluster

  connection {
    type     = "ssh"
    user     = var.ssh.user
    password = var.ssh.password
    host     = var.ssh.host
  }

  provisioner "remote-exec" {
    scripts = [
      "${path.module}/scripts/install-crio.sh",
      "${path.module}/scripts/install-kubeadm.sh"
    ]
  }
}

resource "terraform_data" "cluster" {
  input = local.cluster

  connection {
    type     = "ssh"
    user     = var.ssh.user
    password = var.ssh.password
    host     = var.ssh.host
  }

  provisioner "file" {
    content     = templatefile("${path.module}/templates/config.yml", local.cluster)
    destination = "/tmp/config.yml"
  }

  provisioner "remote-exec" {
    inline = [
      # "sudo kubeadm init --pod-network-cidr=${local.pod_subnet} --upload-certs --cri-socket unix:///var/run/crio/crio.sock --control-plane-endpoint=k8s.appkins.net --skip-phases=addon/kube-proxy",
      "sudo kubeadm init --config /tmp/config.yml",
    ]
  }
}

output "cluster" {
  value = terraform_data.cluster.output
}
