{ pkgs, ... }:

[
  {
    name = "fast-syntax-highlighting";
    src  = pkgs.fetchFromGitHub {
      owner  = "zdharma";
      repo   = "fast-syntax-highlighting";
      rev    = "303eeee81859094385605f7c978801748d71056c";
      sha256 = "0y0jgkj9va8ns479x3dhzk8bwd58a1kcvm4s2mk6x3n19w7ynmnv";
    };
  }
]
