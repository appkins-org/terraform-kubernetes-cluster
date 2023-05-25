log syslog all;

router id {{ NODE_IP }};

protocol device {
        scan time 10;           # Scan interfaces every 10 seconds
}

# Disable automatically generating direct routes to all network interfaces.
protocol direct {
        disabled;               # Disable by default
}

# Forbid synchronizing BIRD routing tables with the OS kernel.
protocol kernel {
        ipv4 {                    # Connect protocol to IPv4 table by channel
                import none;      # Import to table, default is import all
                export none;      # Export to protocol. default is export none
        };
}

# Static IPv4 routes.
protocol static {
      ipv4;
      route {{ POD_CIDR }} via "cilium_host";
}

# BGP peers
protocol bgp uplink0 {
      description "BGP uplink 0";
      local {{ NODE_IP }} as {{ NODE_ASN }};
      neighbor {{ NEIGHBOR_0_IP }} as {{ NEIGHBOR_0_ASN }};
      password {{ NEIGHBOR_PWD }};

      ipv4 {
              import filter {reject;};
              export filter {accept;};
      };
}

protocol bgp uplink1 {
      description "BGP uplink 1";
      local {{ NODE_IP }} as {{ NODE_ASN }};
      neighbor {{ NEIGHBOR_1_IP }} as {{ NEIGHBOR_1_ASN }};
      password {{ NEIGHBOR_PWD }};

      ipv4 {
              import filter {reject;};
              export filter {accept;};
      };
}
