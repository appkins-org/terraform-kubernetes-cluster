#!/usr/bin/bash

ssh $SSH_USER@$SSH_HOST "echo 'y' | sudo kubeadm reset"
ssh $SSH_USER@$SSH_HOST "sudo rm -rf .kube/; sudo rm -rf /etc/kubernetes/; sudo rm -rf /var/lib/kubelet/; sudo rm -rf /var/lib/etcd"
