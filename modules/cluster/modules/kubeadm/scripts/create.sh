#!/usr/bin/bash

ssh $SSH_USER@$SSH_HOST "sudo /usr/bin/bash $REMOTE_DIR/install.sh"

ssh $SSH_USER@$SSH_HOST "sudo kubeadm init --config $REMOTE_DIR/config.yml"

ssh $SSH_USER@$SSH_HOST "mkdir -p /root/.kube; cp -i /etc/kubernetes/admin.conf /root/.kube/config"

# ssh $SSH_USER@$SSH_HOST "kubectl taint nodes --all node-role.kubernetes.io/control-plane-"

eval "ssh $SSH_USER@$SSH_HOST kubectl config view --flatten --kubeconfig=/etc/kubernetes/admin.conf -o json" | jq '{clientkey: .users[0].user["client-key-data"], clientcert: .users[0].user["client-certificate-data"], ca: .clusters[0].cluster["certificate-authority-data"], apiendpoint: .clusters[0].cluster["server"]}'
