{ config, lib, pkgs, ... }:

{
  options.profiles.terminal = {
    enable = lib.mkEnableOption "Basic CLI and TUI tools";
  };

  config = lib.mkIf config.profiles.terminal.enable {
    programs.bat.enable = true;
    programs.exa.enable = true;
    programs.fzf.enable = true;

    programs.git    = import ./git.nix;
    programs.htop   = import ./htop.nix;
    # programs.neovim = import ./neovim { inherit lib pkgs; };
    programs.tmux   = import ./tmux.nix { inherit lib pkgs; };

    programs.direnv = {
      enable = true;
      enableNixDirenvIntegration = true;
      enableZshIntegration = true;
    };

    programs.neofetch = {
      enable = true;
      config = lib.readFile ./neofetch.conf;
    };

    home.packages = with pkgs; [
      bitwarden-cli
      brightnessctl
      fd
      gitAndTools.gh
      gitAndTools.git-ignore
      jq
      manix
      nix-index
      nix-tree
      pandoc
      ranger
      ripgrep
      unzip
      vim
      zip
    ];

    home.sessionVariables = {
      EDITOR = "vim";
    };
  };
}
