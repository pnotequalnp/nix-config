{ config, lib, pkgs, ... }:

{
  options.profiles.development.latex = {
    enable = lib.mkEnableOption "Basic LaTeX tooling";
  };

  config = lib.mkIf config.profiles.development.latex.enable {
    home.packages = [ pkgs.texlive.combined.scheme-full ];

    xdg.configFile."latexmk/latexmkrc".text =
      ''push @generated_exts, "synctex.gz";'';
  };
}
