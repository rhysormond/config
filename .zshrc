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

# source common shell config
source "$HOME/.shrc"
