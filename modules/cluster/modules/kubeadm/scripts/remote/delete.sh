#!/usr/bin/bash

echo "y" | sudo kubeadm reset
sudo rm -rf $HOME/.kube/; sudo rm -rf /etc/kubernetes/; sudo rm -rf /var/lib/kubelet/; sudo rm -rf /var/lib/etcd
rm -rf $HOME/.kube