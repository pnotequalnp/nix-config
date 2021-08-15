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

  dirHashes = rec {
    cache = config.xdg.cacheHome;
    code = "${docs}/code";
    conf = config.xdg.configHome;
    data = config.xdg.dataHome;
    docs = config.xdg.userDirs.documents;
    git = "${docs}/git";
    nix = "${conf}/nix-config";
    pics = config.xdg.userDirs.pictures;
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
