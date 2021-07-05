{ lib, pkgs, ... }:

{
  enable = true;
  escapeTime = 0;
  baseIndex = 0;
  clock24 = true;
  historyLimit = 50000;
  keyMode = "vi";
  shortcut = "s";
  terminal = "tmux-256color";
  plugins = with pkgs.tmuxPlugins; [
    fingers
    open
    pain-control
    sessionist
  ];
  extraConfig = lib.readFile ./tmux.conf;
}
