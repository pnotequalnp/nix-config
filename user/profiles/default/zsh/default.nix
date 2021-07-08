{ config, lib, pkgs, ... }:

let extraFiles = [ ./keybindings.zsh ./settings.zsh ];
in {
  enable = true;
  dotDir = ".config/zsh";

  autocd = true;
  defaultKeymap = "viins";
  enableAutosuggestions = true;
  enableCompletion = true;

  initExtra = lib.concatMapStringsSep "\n" lib.readFile extraFiles;
  initExtraBeforeCompInit = lib.readFile ./completion.zsh;

  history = {
    expireDuplicatesFirst = true;
    extended = true;
    path = "${config.xdg.dataHome}/zsh/history";
  };

  plugins = import ./plugins.nix { inherit pkgs; };
  shellAliases = import ./aliases.nix;
  shellGlobalAliases = {
    "..." = "../..";
    "...." = "../../..";
    "....." = "../../../..";
  };
}
