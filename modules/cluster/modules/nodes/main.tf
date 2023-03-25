resource "vagrant_vm" "kubernetes" {
  name = "kubernetes"
  vagrantfile_dir = "${path.module}"
  env = {
    VAGRANTFILE_HASH = md5(file("${path.module}/Vagrantfile"))
    POD_CIDR = local.pod_cidr
    TOKEN = "yi6muo.4ytkfl3l6vl8zfpk"
  }
  get_ports = true
}
