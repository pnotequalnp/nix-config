{ config, lib, pkgs, util, ... }:

{
  system.stateVersion = "21.05";

  imports = [ ./hardware.nix ./users.nix ];

  sops.secrets = util.secretDir null ./secrets;

  profiles = { networking.enable = true; };

  boot = {
    cleanTmpDir = true;
    kernel.sysctl = {
      "net.ipv4.ip_forward" = 1;
      "net.ipv6.conf.all.forwarding" = 1;
    };
  };

  security.sudo.wheelNeedsPassword = false;

  # services.openssh = {
  #   hostKeys = [{
  #     path = config.sops.secrets."ssh_host_ed25519_key".path;
  #     type = "ed25519";
  #   }];
  #   extraConfig = "HostCertificate ${./crypto/ssh_host_ed25519_key-cert.pub}";
  # };
}
