# Prompt
# Left prompt
PROMPT='%(?.%F{green}√.%F{red}?%?) %B%F{240}%(5~|%-1~/…/%3~|%4~)%f%b %F{magenta}|> %f'
# Right prompt
# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%F{240}%r (%b) %m%u%c%f'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' enable git
# Enable prompt substitution
setopt prompt_subst
# Define the right prompt
RPROMPT=\$vcs_info_msg_0_

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
alias vim="vim -u $HOME/.config/vim/.vimrc"

# Set up homebrew if it's installed
if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Source device-specific config
if [ -f $HOME/.env ]; then
    source $HOME/.env
fi
