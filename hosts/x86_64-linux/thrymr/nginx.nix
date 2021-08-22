{ config, lib, pkgs, ... }:

let
  keyFile = "key.tls.pem";
  domain = "pnotequalnp.com";
  key = config.sops.secrets."${keyFile}".path;
  proxyPass = destination: {
    locations."/".proxyPass = destination;
    addSSL = true;
    sslCertificate = ./crypto + "/${domain}.cloudflare.crt.pem";
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
        locations = {
          "/".return = "404";
          "/.hostname".return = "200 '${config.networking.hostName}'";
        };
        default = true;
        addSSL = true;
        sslCertificate = ./crypto
          + "/${config.networking.hostName}.saturn.crt.pem";
        sslCertificateKey = key;
      };

      "cloud.${domain}" = proxyPass "https://narvi/cloud";
      "git.${domain}" = proxyPass "https://narvi/git";
      "matrix.${domain}" = proxyPass "https://narvi/matrix";
      "pi.${domain}" = proxyPass "https://daphnis";
    };
  };
}
