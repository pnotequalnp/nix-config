{ config, lib, pkgs, ... }:

{
  home.stateVersion = "20.09";

  imports =
    [
      ../modules
      ../profiles
    ];

  profiles = {
    emacs.enable           = false;
    graphical.enable       = false;
    terminal.enable        = true;
    x11-environment.enable = false;

    development = {
      base.enable    = false;
      haskell.enable = false;
      java.enable    = false;
      latex.enable   = false;
    };
  };
}
