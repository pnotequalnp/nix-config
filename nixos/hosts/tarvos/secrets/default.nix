{ config, lib, pkgs, ... }:

{
  sops.secrets = {
    "tarvos.ssh_host_ed25519_key" = {
      sopsFile = ./ssh.yaml;
      key = "ssh_host_ed25519_key";
    };
    "tarvos.ssh_host_ed25519_key.pub" = {
      sopsFile = ./ssh.yaml;
      key = "ssh_host_ed25519_key.pub";
    };
    "tarvos.ssh_host_ed25519_key-cert.pub" = {
      sopsFile = ./ssh.yaml;
      key = "ssh_host_ed25519_key-cert.pub";
    };

    "tarvos.crt.pem" = {
      sopsFile = ./ssl.yaml;
      key = "tarvos.crt.pem";
    };
    "tarvos.key.pem" = {
      sopsFile = ./ssl.yaml;
      key = "tarvos.key.pem";
    };
    "tarvos.dhparam.pem" = {
      sopsFile = ./ssl.yaml;
      key = "dhparam.pem";
    };
  };

}
