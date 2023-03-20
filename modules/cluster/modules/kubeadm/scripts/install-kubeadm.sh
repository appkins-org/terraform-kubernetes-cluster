#!/usr/bin/bash

# Install kubeadm

if ! command -v kubeadm &> /dev/null
then
  sudo apt-get update
  sudo apt-get install -y apt-transport-https ca-certificates curl

  sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

  echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

  sudo apt update
  sudo apt -y install kubelet kubeadm kubectl
  sudo apt-mark hold kubelet kubeadm kubectl
fi
