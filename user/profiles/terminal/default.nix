{ config, lib, pkgs, ... }:

{
  options.profiles.terminal = {
    enable = lib.mkEnableOption "Basic CLI and TUI tools";
  };

  config = lib.mkIf config.profiles.terminal.enable {
    programs.bat.enable = true;
    programs.exa.enable = true;
    programs.fzf.enable = true;

    programs.git = import ./git.nix;
    programs.neovim = import ./neovim { inherit lib pkgs; };
    programs.tmux = import ./tmux.nix { inherit lib pkgs; };

    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv = {
        enable = true;
        enableFlakes = true;
      };
    };

    programs.neofetch = {
      enable = true;
      config = lib.readFile ./neofetch.conf;
    };

    home.packages = with pkgs; [
      bitwarden-cli
      bottom
      brightnessctl
      dnsutils
      fd
      file
      gitAndTools.gh
      gitAndTools.git-ignore
      jq
      kakoune
      lynx
      manix
      nix-index
      nix-tree
      nixfmt
      openssl
      pandoc
      ranger
      ripgrep
      udiskie
      unzip
      zip
    ];

    home.sessionVariables = {
      EDITOR = "nvim";
      MANPAGER = "nvim +Man!";
    };
  };
}
