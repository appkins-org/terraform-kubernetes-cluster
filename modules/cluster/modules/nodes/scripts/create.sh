lxc profile create dev-user-data
lxc profile set dev-user-data user.user-data - < cloud-init-config.yaml
lxc launch ubuntu-daily:bionic test-container -p default -p dev-user-data
lxc launch ubuntu-daily:bionic test-container --config=user.user-data="$(cat userdata.yaml)"
