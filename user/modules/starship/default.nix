{ config, lib, pkgs, ... }:

let cfg = config.programs.starship;
in {
  options.programs.starship.nerdFontIcons =
    lib.mkEnableOption "Use Nerd Font icons instead of emojis";

  config = lib.mkIf cfg.enable {
    programs.starship.settings = lib.mkIf cfg.nerdFontIcons {
      aws.symbol = lib.mkDefault " ";
      conda.symbol = lib.mkDefault " ";
      dart.symbol = lib.mkDefault " ";
      directory.read_only = lib.mkDefault " ";
      docker_context.symbol = lib.mkDefault " ";
      elixir.symbol = lib.mkDefault " ";
      elm.symbol = lib.mkDefault " ";
      git_branch.symbol = lib.mkDefault " ";
      golang.symbol = lib.mkDefault " ";
      hg_branch.symbol = lib.mkDefault " ";
      java.symbol = lib.mkDefault " ";
      julia.symbol = lib.mkDefault " ";
      memory_usage.symbol = lib.mkDefault " ";
      nim.symbol = lib.mkDefault " ";
      nix_shell.symbol = lib.mkDefault " ";
      nodejs.symbol = lib.mkDefault " ";
      package.symbol = lib.mkDefault " ";
      perl.symbol = lib.mkDefault " ";
      php.symbol = lib.mkDefault " ";
      python.symbol = lib.mkDefault " ";
      ruby.symbol = lib.mkDefault " ";
      rust.symbol = lib.mkDefault " ";
      swift.symbol = lib.mkDefault "ﯣ ";
    };
  };
}
