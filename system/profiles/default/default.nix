{ config, nixpkgs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ acpi curl git tmux vim ];

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  users.mutableUsers = true;

  nix = {
    package = pkgs.nixUnstable;
    trustedUsers = [ "root" "@wheel" ];
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      warn-dirty = false
      experimental-features = nix-command flakes ca-references
    '';
    registry.nixpkgs.flake = nixpkgs;
  };

  nixpkgs.config.allowUnfree = true;

  security.sudo.extraConfig = ''
    Defaults lecture = never
  '';

  environment.pathsToLink = [ "/share/zsh" ];

  sops = {
    gnupgHome = "/var/lib/sops";
    sshKeyPaths = [ ];
  };
}
