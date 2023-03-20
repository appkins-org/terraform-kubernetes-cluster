sudo kubeadm init --config /tmp/kubeadm-config.yaml
# Set kubectl config
mkdir -p $HOME/.kube
sudo cp -Rf /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
mkdir -p /home/terraform/.kube/
sudo cp -Rf /etc/kubernetes/admin.conf /home/terraform/.kube/config
sudo chown terraform:terraform /home/terraform/.kube/config
