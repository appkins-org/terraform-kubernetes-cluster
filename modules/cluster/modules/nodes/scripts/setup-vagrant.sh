#!/usr/bin/env bash

sudo apt purge vagrant-libvirt
sudo apt-mark hold vagrant-libvirt
sudo apt install qemu libvirt-daemon-system libvirt-dev ebtables libguestfs-tools
sudo apt install -y vagrant ruby-fog-libvirt
vagrant plugin install vagrant-libvirt
