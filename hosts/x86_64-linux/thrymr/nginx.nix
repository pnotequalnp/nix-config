{ config, lib, pkgs, ... }:

let
  keyFile = "key.tls.pem";
  domain = "pnotequalnp.com";
  cert = ./crypto + "/${domain}.cloudflare.crt.pem";
  key = config.sops.secrets."${keyFile}".path;
  proxyPass = destination: {
    locations."/".proxyPass = destination;
    addSSL = true;
    sslCertificate = cert;
    sslCertificateKey = key;
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
      "hello-there.${domain}" = {
        locations."/".return = "200 'Hello there!'";
        forceSSL = true;
        sslCertificate = cert;
        sslCertificateKey = key;
      };

      "pi.${domain}" = proxyPass "https://daphnis";
    };
  };
}
