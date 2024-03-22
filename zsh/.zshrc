# Prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%F{yellow}(%b)%m%u%c%f '
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' enable git
setopt prompt_subst
PROMPT='%(?.%F{green}[0].%F{red}[%?]) %F{white}%(5~|%-1~/…/%3~|%4~)%f %B$vcs_info_msg_0_%b%F{magenta}|>%f '

# Initialize completion
autoload -U compinit
compinit -D

# Colorize terminal
alias ls='ls -G'
alias ll='ls -lG'
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
export GREP_OPTIONS="--color"

# Nicer history
export HISTFILE="$HOME/.history"
export HISTSIZE=100000
export SAVEHIST=$HISTSIZE

# Use vim as the editor
export EDITOR=vim

# Highlight search results in ack.
export ACK_COLOR_MATCH='red'

# Aliases
alias g="git"

# Set up homebrew if it's installed
if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv 2> /dev/null)"
fi

# Source device-specific config
if [ -f $HOME/.env ]; then
    source $HOME/.env
fi

# Diff two JSON files with jq
jd () {
    diff <(jq --sort-keys . $1) <(jq --sort-keys . $2)
}
