{ config, pkgs, ... }:

{
  # Firewall Configuration
  networking.firewall = {
    enable = true;

    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];

    logRefusedPackets = true;
  };

  # Switch from legacy iptables to modern nftables
  networking.nftables.enable = true;

  # Extra System Hardening
  # protects against spoofing attacks
  # packets that claim to come from an interface they couldn't realistically arrive on.
  boot.kernel.sysctl = {
    "net.ipv4.conf.all.rp_filter" = 1;
    "net.ipv4.conf.default.rp_filter" = 1;
  };

  # Prevent unprivileged users from viewing system dmesg logs
  security.protectKernelImage = true;
}