{ config, lib, pkgs, ... }:

let
  keyFile = "key.tls.pem";
  domain = "pnotequalnp.com";
  cfCert = ./crypto + "/${domain}.cloudflare.crt.pem";
  key = config.sops.secrets."${keyFile}".path;
  proxyPass = destination: {
    locations."/".proxyPass = destination;
    addSSL = true;
    sslCertificate = cfCert;
    sslCertificateKey = key;
  };
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

    virtualHosts = {
      "${config.networking.hostName}" = {
        forceSSL = true;
        sslCertificate = ./crypto + "/${config.networking.hostName}.saturn.crt.pem";
        sslCertificateKey = key;
      };

      "pi.${domain}" = proxyPass "https://daphnis";

      "git.${domain}" = proxyPass "https://narvi/git";
    };
  };
}
