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
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."${config.networking.hostName}" = {
      locations = {
        "/hello".return = "200 'Hello there!'";
        "/git".proxyPass = "http://localhost:3000/";
      };
      forceSSL = true;
      sslCertificate = ./crypto
        + "/${config.networking.hostName}.saturn.crt.pem";
      sslCertificateKey = config.sops.secrets."${keyFile}".path;
    };
  };
}
