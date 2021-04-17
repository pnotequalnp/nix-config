{
  enable = true;
  nerdFontIcons = true;
  settings = {
    add_newline = false;
    nix_shell = {
      symbol = " ";
      format = "[$symbol]($style) ";
    };
    hostname.format = "[$hostname]($style):";
    username.format = "[$user]($style)@";
  };
}
