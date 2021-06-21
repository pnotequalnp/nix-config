{ config, nixpkgs, pkgs, ... }:

{
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  environment.systemPackages = with pkgs; [ acpi curl git tmux vim ];

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      warn-dirty = false
      experimental-features = nix-command flakes ca-references
    '';
    registry.nixpkgs.flake = nixpkgs;
  };

  nixpkgs.config.allowUnfree = true;

  services = {
    upower.enable = true;
    blueman.enable = true;
    dbus.packages = [ pkgs.gnome3.dconf ];
    pcscd.enable = true;
  };

  security.sudo.extraConfig = ''
    Defaults lecture = never
  '';

  environment.pathsToLink = [ "/share/zsh" ];

  hardware = {
    pulseaudio.enable = true;
    bluetooth.enable = true;
  };

  sound.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;

  sops = {
    gnupgHome = "/var/lib/sops";
    sshKeyPaths = [ ];
  };
}
