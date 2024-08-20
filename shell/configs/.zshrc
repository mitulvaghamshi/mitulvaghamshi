PROMPT="%B%F{178}[ %c ]%f%b %(?.%F{green}.%F{red}%? )%f $ "

DBIN="$HOME/Developer/bin"

NODE="$DBIN/.node/bin"
DENO="$DBIN/.deno/bin"
RUST="$DBIN/.cargo/bin"
RUBY="$DBIN/.rbenv/shims"
GEMS="$DBIN/.gem/ruby/3.1.7/gems"
FLTR="$DBIN/.flutter/bin"
PUBC="$DBIN/.pub-cache/bin"
AADB="$DBIN/Library/Android/sdk/platform-tools"
ANGY="$HOME/.antigravity/antigravity/bin"

EXES="$NODE:$DENO:$RUST:$GEMS:$RUBY:$PUBC:$FLTR:$AADB:$ANGY"

export PATH="$EXES:$PATH"

autoload -Uz compinit && compinit
autoload -Uz vcs_info
precmd_vcs_info(){vcs_info}
precmd_functions+=(precmd_vcs_info)
setopt prompt_subst
RPROMPT='%B%F{033}${vcs_info_msg_0_}%f%b'
zstyle ':vcs_info:git:*' formats '(%b)'

alias rbenv="$DBIN/.rbenv/bin/rbenv"

