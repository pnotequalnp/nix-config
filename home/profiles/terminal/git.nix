{
  enable = true;
  userName = "Kevin Mullins";
  userEmail = "46154511+pnotequalnp@users.noreply.github.com";

  aliases = {
    graph  = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
    graphh = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all";
  };

  ignores = [
    ".direnv/"
    ".vscode/"
    ".envrc"
    "result/"
    "result"
  ];

  extraConfig = {
    pull = {
      ff = "only";
      rebase = true;
    };
    github.user = "pnotequalnp";
    tag.gpgSign = true;
  };

  signing = {
    signByDefault = true;
    key = "361820A45DB41E9A";
  };
}
