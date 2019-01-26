# dotfile installation config
alias config="git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# add ~/bin to $PATH
export PATH="$HOME/bin:$PATH"

# os-specific configuration
if [[ `uname` == 'Linux' ]]; then
    # pbcopy && pbpaste from MacOS
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
fi

# history
export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=100000
export HISTFILESIZE=100000

# colors
export CLICOLOR=true
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export TERM="xterm-256color"

# text editor
export EDITOR="vim"
export FUZZY_SELECTOR="fzy"

# oh-my-zsh customization
ZSH_CUSTOM="$HOME/.zsh_custom"

# zsh plugins
plugins=(
    git colorize colored-man-pages pip bundler vi-mode history-substring-search
    zsh-syntax-highlighting zsh-autosuggestions # from submodules
)

# zsh theme
ZSH_THEME="refined"

# zsh completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # case insensitive
zstyle ':completion:*' insert-tab pending           # handle pasted tabs better

# zsh ls after every cd
function chpwd() {
    ls
}

# oh-my-zsh package control
export ZSH="$HOME/.oh-my-zsh"
source "$ZSH/oh-my-zsh.sh"

# source system-specific env
source ~/.env

