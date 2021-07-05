zmodload -i zsh/complist
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' max-errors 1 numeric
