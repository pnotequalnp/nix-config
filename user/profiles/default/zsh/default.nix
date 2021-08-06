{ config, lib, pkgs, ... }:

let extraFiles = [ ./functions.zsh ./keybindings.zsh ./settings.zsh ];
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

  dirHashes = {
    docs = "$HOME/documents";
    code = "$HOME/documents/code";
    nix = "$XDG_CONFIG_HOME/nix-config";
    conf = "$XDG_CONFIG_HOME";
    data = "$XDG_DATA_HOME";
    cache = "$XDG_CACHE_HOME";
  };

  fzf = {
    pathCompletionCommand =
      ''${pkgs.fd}/bin/fd --hidden --follow --exclude ".git" . "$1"'';
    directoryCompletionCommand =
      ''${pkgs.fd}/bin/fd --type d --hidden --follow --exclude ".git" . "$1"'';
  };

  plugins = import ./plugins.nix { inherit pkgs; };
  shellAliases = import ./aliases.nix;
  shellGlobalAliases = {
    "..." = "../..";
    "...." = "../../..";
    "....." = "../../../..";
  };
}
