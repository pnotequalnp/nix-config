{ config, lib, nixpkgs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ acpi curl git tmux vim ];

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  users = {
    defaultUserShell = pkgs.zsh;
    mutableUsers = true;
  };

  nix = {
    package = pkgs.nixUnstable;

    trustedUsers = [ "root" "@wheel" ];

    binaryCaches = [ "https://nix-community.cachix.org" ];

    binaryCachePublicKeys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];

    registry.nixpkgs.flake = nixpkgs;

    extraOptions = ''
      builders-use-substitutes = true
      experimental-features = nix-command flakes ca-references
      keep-derivations = true
      keep-outputs = true
      warn-dirty = false
    '';
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
