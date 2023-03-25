#!/usr/bin/bash

FRRHOSTNAME=frr.appkins
FRRASNUMBER=64524
FRRROUTERID=10.200.0.61
K8SASNUMBER=64525
NODE1IP=10.200.0.12 # IP of the 1st node - control plane
NODE2IP=10.200.0.13 # IP of the 2nd node - worker 1
NODE3IP=10.200.0.14 # IP of the 3rd node - worker 2
K8SNETWORK=192.168.50.75/30
cat <<EOF> /etc/frr/frr.conf
# default to using syslog. /etc/rsyslog.d/45-frr.conf places the log
# in /var/log/frr/frr.log
!
frr defaults traditional
hostname ${FRRHOSTNAME}
log syslog
no ipv6 forwarding
service integrated-vtysh-config
!
router bgp ${FRRASNUMBER}
 no bgp ebgp-requires-policy
 bgp log-neighbor-changes
 bgp router-id ${FRRROUTERID}
 neighbor ${NODE1IP} remote-as ${K8SASNUMBER}
 neighbor ${NODE1IP} update-source frr0
 neighbor ${NODE1IP} description node1
 neighbor ${NODE2IP} remote-as ${K8SASNUMBER}
 neighbor ${NODE2IP} update-source frr0
 neighbor ${NODE2IP} description node2
 neighbor ${NODE3IP} update-source frr0
 neighbor ${NODE3IP} remote-as ${K8SASNUMBER}
 neighbor ${NODE3IP} description node3
!
 address-family ipv4 unicast
  network ${K8SNETWORK}
  neighbor ${NODE1IP} activate
  neighbor ${NODE2IP} activate
  neighbor ${NODE3IP} activate
  no neighbor ${NODE1IP} send-community
  no neighbor ${NODE2IP} send-community
  no neighbor ${NODE3IP} send-community
  neighbor ${NODE1IP} next-hop-self
  neighbor ${NODE2IP} next-hop-self
  neighbor ${NODE3IP} next-hop-self
 exit-address-family
 !
!
route-map ALLOW-ALL permit 100
!
line vty
!
end
EOF
