{ config, lib, pkgs, ... }:

{
  sops.secrets = {
    tarvos_ssh_host_ed25519_key = {
      sopsFile = ./ssh.yaml;
      key = "ssh_host_ed25519_key";
    };
    "tarvos_ssh_host_ed25519_key.pub" = {
      sopsFile = ./ssh.yaml;
      key = "ssh_host_ed25519_key.pub";
    };
    "tarvos_ssh_host_ed25519_key-cert.pub" = {
      sopsFile = ./ssh.yaml;
      key = "ssh_host_ed25519_key-cert.pub";
    };
  };

}
