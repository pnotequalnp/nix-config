{ config, lib, pkgs, ... }:

{
  imports = [ ./fonts.nix ];

  programs.zsh = import ./zsh { inherit config lib pkgs; };

  programs.ssh = {
    enable = true;
    extraConfig = "AddKeysToAgent yes";
  };

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
  };

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      desktop = "\$HOME/";
      documents = "\$HOME/documents";
      download = "\$HOME/downloads";
      pictures = "\$HOME/pictures";
    };
  };
}
