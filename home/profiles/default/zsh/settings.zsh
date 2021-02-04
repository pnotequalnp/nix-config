ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history)
stty stop undef
stty start undef
setopt EXTENDED_GLOB CSH_NULL_GLOB
setopt AUTO_PUSHD PUSHD_IGNORE_DUPS
unsetopt BEEP
