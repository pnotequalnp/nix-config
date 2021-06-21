{ config, lib, pkgs, ... }:

{
  options.profiles.emacs = {
    enable = lib.mkEnableOption "Doom Emacs";
  };

  config = lib.mkIf config.profiles.emacs.enable {
    programs.doom-emacs = {
      enable = true;
      package = pkgs.emacsGcc;
      doomPrivateDir = ./doom;
    };

    services.emacs = {
      enable = true;
    };
  };
}
