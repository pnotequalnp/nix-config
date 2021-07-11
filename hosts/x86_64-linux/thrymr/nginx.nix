{ config, lib, pkgs, ... }:

{
  sops.secrets."key.tls.pem".owner = config.users.users.nginx.name;
  sops.secrets."key.tls.pem".group = config.users.users.nginx.group;

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."hello-there.pnotequalnp.com" = {
      locations."/".return = "200 'Hello there!'";
      forceSSL = true;
      sslCertificate = ./crypto/pnotequalnp.com.cloudflare.crt.pem;
      sslCertificateKey = config.sops.secrets."key.tls.pem".path;
    };
  };
}
