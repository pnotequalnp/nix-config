ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history)
stty stop undef
stty start undef
setopt CSH_NULL_GLOB
setopt AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_MINUS
unsetopt BEEP
KEYTIMEOUT=5
