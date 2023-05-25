#!/usr/bin/bash

ssh $SSH_USER@$SSH_HOST "/usr/local/bin/k3s-uninstall.sh; sudo rm -rf .kube/"
