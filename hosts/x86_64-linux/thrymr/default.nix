{ config, lib, pkgs, util, ... }:

{
  system.stateVersion = "21.05";

  imports = [ ./hardware.nix ./users.nix ];

  sops.secrets = util.secretDir null ./secrets;

  profiles = { networking.enable = true; };

  boot.cleanTmpDir = true;

  networking.firewall.allowedTCPPorts = [ 443 ];

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBVJXYSV6hN7gaEo1KnXq6svCmgK4W92bBQ632CrgbR7 openpgp:0x5DBE95BE"
  ];

  security.sudo.wheelNeedsPassword = false;

  # services.openssh = {
  #   hostKeys = [{
  #     path = config.sops.secrets."ssh_host_ed25519_key".path;
  #     type = "ed25519";
  #   }];
  #   extraConfig = "HostCertificate ${./crypto/ssh_host_ed25519_key-cert.pub}";
  # };
}
