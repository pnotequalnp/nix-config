{ config, lib, pkgs, ... }:

let
  cfg = config.programs.zsh.fzf;
  pathComp = lib.mapNullable (command: ''
    _fzf_compgen_path() {
      ${command}
    }
  '') cfg.pathCompletionCommand;
  dirComp = lib.mapNullable (command: ''
    _fzf_compgen_dir() {
      ${command}
    }
  '') cfg.directoryCompletionCommand;
in {
  options.programs.zsh.fzf = {
    pathCompletionCommand = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      example = ''fd --hidden --follow --exclude ".git" . "$1"'';
    };
    directoryCompletionCommand = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      example = ''fd --type d --hidden --follow --exclude ".git" . "$1"'';
    };
  };

  config = lib.mkIf config.programs.zsh.enable {
    home.packages = [ pkgs.exa ];
    programs.zsh.initExtraBeforeCompInit = lib.concatStringsSep "\n"
      (lib.filter (s: s != null) [ pathComp dirComp ]);
  };
}
