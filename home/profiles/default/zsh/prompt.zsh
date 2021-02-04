autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats '%F{41} %b%f '
precmd() { vcs_info }
setopt PROMPT_SUBST

[[ -v SSH_CLIENT ]] && sshSeg='%F{196}  %n@%m%f '

[[ -v IN_NIX_SHELL ]] && nixSeg='%F{135}  %f'

pathSeg='%F{38}%(1C.%3~/./)%f'
jobsSeg='%(1j.%F{208}省%j%f .)'
PROMPT='${sshSeg}${nixSeg}${jobsSeg}${vcs_info_msg_0_}${pathSeg} > '

zle-line-init() {
  echo -ne "\e[5 q"
}

function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]]; then
    echo -ne "\e[1 q"
  else
    echo -ne "\e[5 q";
  fi
}

zle -N zle-line-init
zle -N zle-keymap-select
KEYTIMEOUT=5
