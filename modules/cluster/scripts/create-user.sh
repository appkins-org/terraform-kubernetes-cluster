sudo adduser terraform
sudo usermod -aG sudo terraform
sudo passwd terraform
ssh-keygen -t rsa -b 4096 -C terraform -f /home/terraform/.ssh/id_ed25519
