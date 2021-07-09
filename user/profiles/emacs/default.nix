{ config, lib, pkgs, ... }:

{
  options.profiles.emacs.enable = lib.mkEnableOption "Doom Emacs";

  config = lib.mkIf config.profiles.emacs.enable {
    programs.emacs = {
      enable = true;
      package = pkgs.emacsPgtkGcc;
      extraPackages = (epkgs: [ epkgs.vterm ]);
    };

    services.emacs.enable = true;
  };
}
