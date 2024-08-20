# -- Last modified: Jun 25, 2025 at 22:04:46 EDT

# -- Main prompt format
#
PROMPT="%B%F{178}[ %c ]%f%b %(?.%F{034}.%F{088}%? )%f $ "

# -- Path variables
#
RUBY="$HOME/.rbenv/shims"
GEMS="$HOME/.gem/ruby/3.1.0/bin"
WEBP="$HOME/.webp/bin"
DENO="$HOME/.deno/bin"
RUST="$HOME/.cargo/bin"
PUB="$HOME/.pub-cache/bin"
FLUTTER="$HOME/flutter/bin"
KOTLIN="$HOME/.konan/kotlin-native-prebuilt-macos-aarch64-2.1.0/bin"

# -- Export path values
#
export PATH="$RUBY:$GEMS:$WEBP:$DENO:$RUST:$PUB:$FLUTTER:$KOTLIN:$PATH"

# -- GitHub branch prompt
#
autoload -Uz compinit && compinit
autoload -Uz vcs_info
precmd_vcs_info(){vcs_info}
precmd_functions+=(precmd_vcs_info)
setopt prompt_subst
RPROMPT='%B%F{033}${vcs_info_msg_0_}%f%b'
zstyle ':vcs_info:git:*' formats '(%b)'

# -- NodeJS initialization
#
# eval "$(fnm env)"

# -- Aliases
#
alias rbenv="$HOME/.rbenv/rbenv/bin/rbenv"
alias x86="arch --x86_64 "

# -- Auto Correct prompt
#
# setopt correct
# export SPROMPT="Correct %R to %r? [Yes, No, Abort, Edit] "
# export SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r$reset_color? [Yes, No, Abort, Edit] "
