{ config, lib, pkgs, ... }:

let keyFile = "key.tls.pem";
in {
  sops.secrets."${keyFile}" = {
    owner = config.users.users.nginx.name;
    group = config.users.users.nginx.group;
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedTlsSettings = true;

    virtualHosts."${config.networking.hostName}" = {
      locations = {
        "/".return = "404";
        "/.hostname".return = "200 '${config.networking.hostName}'";
      };
      default = true;
      addSSL = true;
      sslCertificate = ./crypto
        + "/${config.networking.hostName}.saturn.crt.pem";
      sslCertificateKey = config.sops.secrets."${keyFile}".path;
    };
  };
}
