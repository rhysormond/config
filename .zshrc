# launch tmux on startup
if [ "$TMUX" = "" ]; then tmux; fi

# dotfile installation config
alias config="git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
alias config-update="config pull && config submodule update --init --recursive"

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
export FUZZY_SELECTOR="selecta"

# add python shims
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export VIRTUALENV_ROOT="$HOME/.pyenv_custom/pyenv-virtualenv"
export PATH="$VIRTUALENV_ROOT/bin:$PATH"
export PYENV_HOOK_PATH="$PYENV_HOOK_PATH:$VIRTUALENV_ROOT/etc/pyenv.d"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# add ruby shims
export RBENV_ROOT="$HOME/.rbenv"
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init -)"

# oh-my-zsh customization
ZSH_CUSTOM="$HOME/.zsh_custom"

# zsh plugins
plugins=(
    git colorize colored-man-pages pip bundler  # from oh-my-zsh
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

