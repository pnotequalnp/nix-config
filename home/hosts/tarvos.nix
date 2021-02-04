{ config, lib, pkgs, ... }:

{
  imports =
    [
      ../modules
      ../profiles
    ];

  profiles = {
    emacs.enable           = true;
    graphical.enable       = true;
    terminal.enable        = true;
    x11-environment.enable = true;

    development = {
      base.enable    = true;
      haskell.enable = true;
      java.enable    = true;
      latex.enable   = true;
    };
  };
}
