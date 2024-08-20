# -- last modified: Oct 28, 2025 at 22:53:50 EDT 

# -- prompt
#
PROMPT="%B%F{178}[ %c ]%f%b %(?.%F{034}.%F{088}%? )%f $ "

# -- vars
#
WEBP="$HOME/.webp/bin"
RUST="$HOME/.cargo/bin"
FLTR="$HOME/flutter/bin"
PUB="$HOME/.pub-cache/bin"

# -- export path
#
export PATH="$WEBP:$RUST:$FLTR:$PUB:$PATH"

# -- right prompt (git)
#
autoload -Uz compinit && compinit
autoload -Uz vcs_info
precmd_vcs_info(){vcs_info}
precmd_functions+=(precmd_vcs_info)
setopt prompt_subst
RPROMPT='%B%F{033}${vcs_info_msg_0_}%f%b'
zstyle ':vcs_info:git:*' formats '(%b)'

# -- aliases
#
alias rosetta="arch --x86_64 "
alias deno="$HOME/.deno/bin/deno"
alias gem="$HOME/.rbenv/shims/gem"
alias ruby="$HOME/.rbenv/shims/ruby"
alias rbenv="$HOME/.rbenv/bin/rbenv"

# -- node init
#
# eval "$(fnm env)"

