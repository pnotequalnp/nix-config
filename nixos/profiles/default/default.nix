{ config, pkgs, ... }:

{
  users = import ./users.nix { inherit pkgs; };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  environment.systemPackages = with pkgs; [
    acpi
    curl
    git
    tmux
    vim
  ];

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
      experimental-features = nix-command flakes ca-references
    '';
  };

  services = {
    upower.enable = true;
    blueman.enable = true;
    dbus.packages = [ pkgs.gnome3.dconf ];
  };

  environment.pathsToLink = [ "/share/zsh" ];

  hardware = {
    pulseaudio.enable = true;
    bluetooth.enable = true;
  };

  sound.enable = true;

  virtualisation.docker.enable = true;
}
