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

# zsh theme
ZSH_THEME="refined"

# zsh plugins
plugins=(
    git colorize colored-man-pages pip bundler  # default
    zsh-syntax-highlighting zsh-autosuggestions # installed separately
)

# zsh completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # case insensitive
zstyle ':completion:*' insert-tab pending           # handle pasted tabs better

# zsh ls after every cd
function chpwd() {
    ls
}

# zsh package control
export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

# add shims to $PATH
export PYENV_ROOT="$HOME/.pyenv"
export RBENV_ROOT="$HOME/.rbenv"
export PATH="$PYENV_ROOT/bin:$RBENV_ROOT/bin:$PATH"

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(rbenv init -)"

# source system-specific env
source ~/.env
