# -- prompt
PROMPT="%B%F{178}[ %c ]%f%b %(?.%F{green}.%F{red}%? )%f $ "

# Enable colors for `ls` 
# export CLICOLOR=1

# -- path
DENO="$HOME/.deno/bin"
RUST="$HOME/.cargo/bin"
RUBY="$HOME/.rbenv/shims"
GEMS="$HOME/.gem/ruby/3.1.7/gems"
FLTR="$HOME/flutter/bin"
PUBC="$HOME/.pub-cache/bin"

# -- export path
export PATH="$DENO:$RUST:$GEMS:$RUBY:$PUBC:$FLTR:$PATH"

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

