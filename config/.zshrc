PROMPT="%B%F{178}[ %c ]%f%b %(?.%F{green}.%F{red}%? )%f $ "

NODE="$HOME/node/bin"
DENO="$HOME/.deno/bin"
RUST="$HOME/.cargo/bin"
RUBY="$HOME/.rbenv/shims"
GEMS="$HOME/.gem/ruby/3.1.7/gems"
FLTR="$HOME/flutter/bin"
PUBC="$HOME/.pub-cache/bin"
DART="$HOME/Library/Application Support/Dart/install/bin" 
AADB="$HOME/Library/Android/sdk/platform-tools"
ANGY="$HOME/.antigravity/antigravity/bin"

EXES="$NODE:$DENO:$RUST:$GEMS:$RUBY:$PUBC:$DART:$FLTR:$AADB:$ANGY"

export PATH="$EXES:$PATH"

autoload -Uz compinit && compinit
autoload -Uz vcs_info
precmd_vcs_info(){vcs_info}
precmd_functions+=(precmd_vcs_info)
setopt prompt_subst
RPROMPT='%B%F{033}${vcs_info_msg_0_}%f%b'
zstyle ':vcs_info:git:*' formats '(%b)'

alias rbenv="$HOME/.rbenv/bin/rbenv"

