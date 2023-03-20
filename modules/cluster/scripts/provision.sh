


sudo kubeadm init \
  --pod-network-cidr=10.217.0.0/16 \
  --upload-certs \
  --cri-socket unix:///var/run/crio/crio.sock \
  --control-plane-endpoint=k8s.appkins.net \
  --skip-phases=addon/kube-proxy

mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

function install_k8s() {
  sudo apt-get update
  sudo apt-get install -y apt-transport-https ca-certificates curl

  sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

  echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

  sudo apt update
  sudo apt -y install kubelet kubeadm kubectl
  sudo apt-mark hold kubelet kubeadm kubectl
}

function install_cri_o() {
  # Ensure you load modules
  sudo modprobe overlay
  sudo modprobe br_netfilter

  # Set up required sysctl params
  sudo tee /etc/sysctl.d/kubernetes.conf<<EOF
  net.bridge.bridge-nf-call-ip6tables = 1
  net.bridge.bridge-nf-call-iptables = 1
  net.ipv4.ip_forward = 1
EOF

  # Reload sysctl
  sudo sysctl --system

  # Add Cri-o repo
  sudo su -
  export OS="xUbuntu_20.04"
  export VERSION=1.26
  echo "deb [signed-by=/usr/share/keyrings/libcontainers-archive-keyring.gpg] https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/ /" | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
  echo "deb [signed-by=/usr/share/keyrings/libcontainers-crio-archive-keyring.gpg] https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/$VERSION/$OS/ /" | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable:cri-o:$VERSION.list

  mkdir -p /usr/share/keyrings
  curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/Release.key | gpg --dearmor -o /usr/share/keyrings/libcontainers-archive-keyring.gpg
  curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/$VERSION/$OS/Release.key | gpg --dearmor -o /usr/share/keyrings/libcontainers-crio-archive-keyring.gpg

  # Install CRI-O
  sudo apt update
  sudo apt install cri-o cri-o-runc

  # Update CRI-O CIDR subnet
  sudo sed -i 's/10.85.0.0/192.168.0.0/g' /etc/cni/net.d/100-crio-bridge.conf
  sudo sed -i 's/10.85.0.0/192.168.0.0/g' /etc/cni/net.d/100-crio-bridge.conflist

  # Start and enable Service
  sudo systemctl daemon-reload
  sudo systemctl restart crio
  sudo systemctl enable crio
  sudo systemctl status crio
}

function configure_k8s() {
  kubeadm init --control-plane-endpoint k8s.appkins.net \
               --pod-network-cidr=10.244.0.0/24 \
               --skip-phases=addon/kube-proxy

}

install_k8s
install_cri_o
