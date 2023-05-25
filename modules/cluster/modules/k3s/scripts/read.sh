#!/usr/bin/bash

# Exit if any of the intermediate steps fail
set -e

REMOTE_KUBECONFIG=/etc/rancher/k3s/k3s.yaml

eval "ssh $SSH_USER@$SSH_HOST kubectl config view --flatten --kubeconfig=$REMOTE_KUBECONFIG -o json" | jq '{clientkey: .users[0].user["client-key-data"], clientcert: .users[0].user["client-certificate-data"], ca: .clusters[0].cluster["certificate-authority-data"], apiendpoint: .clusters[0].cluster["server"]}'
