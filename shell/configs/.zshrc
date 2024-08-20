# -- last modified: Oct 19, 2025 at 00:53:36 EDT

# -- ps1
#
PROMPT="%B%F{178}[ %c ]%f%b %(?.%F{034}.%F{088}%? )%f $ "

# -- vars
#
WEBP="$HOME/.webp/bin"
DENO="$HOME/.deno/bin"
RUST="$HOME/.cargo/bin"
RUBY="$HOME/.rbenv/shims"
PUB="$HOME/.pub-cache/bin"
FLUTTER="$HOME/flutter/bin"

# -- export path
#
export PATH="$WEBP:$DENO:$RUST:$RUBY:$PUB:$FLUTTER:$PATH"

# -- git init
#
autoload -Uz compinit && compinit
autoload -Uz vcs_info
precmd_vcs_info(){vcs_info}
precmd_functions+=(precmd_vcs_info)
setopt prompt_subst
RPROMPT='%B%F{033}${vcs_info_msg_0_}%f%b'
zstyle ':vcs_info:git:*' formats '(%b)'

# -- node init
#
# eval "$(fnm env)"

# -- aliases
#
alias rbenv="$HOME/.rbenv/bin/rbenv"
alias x86="arch --x86_64 "

