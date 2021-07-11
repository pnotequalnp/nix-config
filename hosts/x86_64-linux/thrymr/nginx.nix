{ config, lib, pkgs, ... }:

let
  keyFile = "key.tls.pem";
  proxyPass = destination: {
    locations."/".proxyPass = destination;
    addSSL = true;
    sslCertificate = ./crypto/pnotequalnp.com.cloudflare.crt.pem;
    sslCertificateKey = config.sops.secrets."${keyFile}".path;
  };
in {
  sops.secrets."${keyFile}" = {
    owner = config.users.users.nginx.name;
    group = config.users.users.nginx.group;
  };

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts = {
      "hello-there.pnotequalnp.com" = {
        locations."/".return = "200 'Hello there!'";
        forceSSL = true;
        sslCertificate = ./crypto/pnotequalnp.com.cloudflare.crt.pem;
        sslCertificateKey = config.sops.secrets."${keyFile}".path;
      };

      "pi.pnotequalnp.com" = proxyPass "https://daphnis";
    };
  };
}
