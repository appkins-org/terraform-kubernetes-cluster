#!/bin/bash

# Exit if any of the intermediate steps fail
set -e

# Extract "foo" and "baz" arguments from the input into
# FOO and BAZ shell variables.
# jq will ensure that the values are properly quoted
# and escaped for consumption by the shell.
eval "$(jq -r '@sh "SSH_HOST=\(.ssh_host) SSH_USER=\(.ssh_user)"')"

eval "ssh $SSH_USER@$SSH_HOST kubectl config view --flatten --kubeconfig=/etc/kubernetes/admin.conf -o json" | jq '{clientkey: .users[0].user["client-key-data"], clientcert: .users[0].user["client-certificate-data"], ca: .clusters[0].cluster["certificate-authority-data"], apiendpoint: .clusters[0].cluster["server"]}'
