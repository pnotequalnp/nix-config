{ config, lib, pkgs, ... }:

let
  extraFiles = [
    ./keybindings.zsh
    ./prompt.zsh
    ./settings.zsh
  ];
in {
  enable = true;
  dotDir = ".config/zsh";

  autocd                = true;
  defaultKeymap         = "viins";
  enableAutosuggestions = true;
  enableCompletion      = true;

  initExtra               = lib.concatMapStringsSep "\n" lib.readFile extraFiles;
  initExtraBeforeCompInit = lib.readFile ./completion.zsh;

  history = {
    expireDuplicatesFirst = true;
    extended              = true;
    path                  = "\$XDG_DATA_HOME/zsh/history";
  };

  plugins      = import ./plugins.nix { inherit pkgs; };
  shellAliases = import ./aliases.nix;
  shellGlobalAliases = {
    "..."   = "../..";
    "...."  = "../../..";
    "....." = "../../../..";
  };

  envExtra = ". /home/kevin/.nix-profile/etc/profile.d/hm-session-vars.sh";
}
