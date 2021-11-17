{ config, lib, pkgs, ... }:

{
  options.profiles.terminal = {
    enable = lib.mkEnableOption "Basic CLI and TUI tools";
    neovim = lib.mkEnableOption "Neovim";
  };

  config = lib.mkMerge [
    (lib.mkIf config.profiles.terminal.enable {
      profiles.terminal.neovim = lib.mkDefault true;

      programs.git = import ./git.nix;
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
        graphviz
        jq
        kakoune
        lynx
        manix
        nix-du
        nix-index
        nix-tree
        nixfmt
        openssl
        pandoc
        ranger
        ripgrep
        rnix-lsp
        udiskie
        unzip
        wget
        xclip
        zip
      ];
    })
    (lib.mkIf config.profiles.terminal.neovim {
      programs.neovim = import ./neovim { inherit lib pkgs; };

      home.sessionVariables = {
        EDITOR = "nvim";
        MANPAGER = "nvim +Man!";
      };
    })
  ];
}
