#!/usr/bin/bash

# Exit if any of the intermediate steps fail
set -e

eval "ssh $SSH_USER@$SSH_HOST kubectl config view --flatten --kubeconfig=/etc/kubernetes/admin.conf -o json" | jq '{clientkey: .users[0].user["client-key-data"], clientcert: .users[0].user["client-certificate-data"], ca: .clusters[0].cluster["certificate-authority-data"], apiendpoint: .clusters[0].cluster["server"]}'
