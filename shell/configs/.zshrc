# -- prompt
PROMPT="%B%F{178}[ %c ]%f%b %(?.%F{green}.%F{red}%? )%f $ "

# Enable colors for `ls` 
# export CLICOLOR=1

# -- path
DENO="$HOME/.deno/bin"
RUST="$HOME/.cargo/bin"
RUBY="$HOME/.rbenv/shims"
FLTR="$HOME/flutter/bin"
PUB="$HOME/.pub-cache/bin"

# -- export path
export PATH="$DENO:$RUST:$RUBY:$FLTR:$PUB:$PATH"

# -- right prompt (git)
autoload -Uz compinit && compinit
autoload -Uz vcs_info
precmd_vcs_info(){vcs_info}
precmd_functions+=(precmd_vcs_info)
setopt prompt_subst
RPROMPT='%B%F{033}${vcs_info_msg_0_}%f%b'
zstyle ':vcs_info:git:*' formats '(%b)'

# -- aliases
alias rbenv="$HOME/.rbenv/bin/rbenv"

# -- node init
# eval "$(fnm env)"

