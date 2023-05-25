#!/usr/bin/bash

REMOTE_KUBECONFIG=/etc/rancher/k3s/k3s.yaml

REMOTE_CMDS=(
  "INSTALL_K3S_EXEC='--flannel-backend=none --disable-network-policy --disable-kube-proxy' K3S_TOKEN=$K3S_TOKEN $REMOTE_DIR/install.sh"
  "mkdir -p /root/.kube; cp -i $REMOTE_KUBECONFIG /root/.kube/config"
)

for cmd in "${REMOTE_CMDS[@]}"; do
  ssh $SSH_USER@$SSH_HOST "$cmd"
done

# ssh $SSH_USER@$SSH_HOST "kubectl taint nodes --all node-role.kubernetes.io/control-plane-"

eval "ssh $SSH_USER@$SSH_HOST kubectl config view --flatten --kubeconfig=$REMOTE_KUBECONFIG -o json" | jq '{clientkey: .users[0].user["client-key-data"], clientcert: .users[0].user["client-certificate-data"], ca: .clusters[0].cluster["certificate-authority-data"], apiendpoint: .clusters[0].cluster["server"]}'
